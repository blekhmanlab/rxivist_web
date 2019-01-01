#     Rxivist, a system for crawling papers published on bioRxiv
#     and organizing them in ways that make it easier to find new
#     or interesting research. Includes a web application for
#     the display of data.
#     Copyright (C) 2018 Regents of the University of Minnesota

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU Affero General Public License as
#     published by the Free Software Foundation, version 3.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU Affero General Public License for more details.

#     You should have received a copy of the GNU Affero General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.

#     Any inquiries about this software or its use can be directed to
#     Professor Ran Blekhman at the University of Minnesota:
#     email: blekhman@umn.edu
#     mail: MCB 6-126, 420 Washington Avenue SE, Minneapolis, MN 55455
#     http://blekhmanlab.org/

"""Definition of web service and initialization of the server.

This is the entrypoint for the application, the script called
when the server is started and the router for all user requests.
"""
import re

import bottle
import requests

import helpers
import config
import docs

# - ROUTES -

# WEB PAGES
#     Homepage / search results
@bottle.get('/')
def index():
  error = ""
  view = bottle.request.query.view
  if view is None or view not in ["standard", "print"]:
    view = "standard"
  entity = bottle.request.query.entity
  if entity is None or entity == "":
    entity = "papers"
  category_list = helpers.rxapi("/v1/data/categories")["results"]
  stats = helpers.rxapi("/v1/data/stats")
  results = {} # a list of articles for the current page
  respheaders = None

  try:
    if entity == "authors":
      category_filter = bottle.request.query.getall('category')
      if len(category_filter) == 0:
        category = ""
      else:
        category = category_filter[0] # just one category for author ranks for now
        category_filter = [category_filter[0]]
      results = helpers.rxapi(f"/v1/authors?category={category}")
    elif entity == "papers":
      results, respheaders = helpers.rxapi(f"/v1/papers?{bottle.request.query_string}", headers=True)
  except Exception as e:
    print(e)
    error = f"There was a problem with the submitted query: {e}"
    bottle.response.status = 500

  # Take the current query string and turn it into a template that any page
  # number can get plugged into:
  if "page=" in bottle.request.query_string:
    pagelink =  "/?{}".format(re.sub(r"page=\d*", "page=", bottle.request.query_string))
  else:
    pagelink = f"/?{bottle.request.query_string}&page="


  metric = ""
  timeframe = ""
  page = ""
  page_size = ""
  totalcount = ""
  query = ""

  if entity == "papers":
    try:
      metric = results["query"]["metric"]
      timeframe = results["query"]["timeframe"]
      category_filter = results["query"]["categories"]
      page = results["query"]["current_page"]
      page_size = results["query"]["page_size"]
      totalcount = results["query"]["total_results"]
      query = results["query"]["text_search"]
    except Exception as e:
      if "error" in results.keys():
        error = results["error"]
      else:
        error = str(e) # TODO: this is bad
      return error

  results = results["results"]

  # figure out the page title
  if entity == "papers":
    title = "Most "
    if metric == "twitter":
      title += "tweeted"
    elif metric == "downloads":
      title += "downloaded"
    if query != "":
      title += f" papers related to \"{query},\" "
    else:
      title += " bioRxiv papers, "
    printable_times = {
      "alltime": "all time",
      "ytd": "year to date",
      "lastmonth": "since beginning of last month",
      "day": "last 24 hours",
      "week": "last 7 days",
      "month": "last 30 days",
      "year": "last 365 days"
    }
    title += printable_times[timeframe]
  elif entity == "authors":
    title = "Authors with most downloads, all-time"

  if bottle.request.query_string == "":
    bottle.response.set_header("Cache-Control", f"max-age={config.front_page_cache}, stale-while-revalidate=172800")
  # use whatever cache-control headers are sent to us from the API
  if respheaders is not None and "Cache-Control" in respheaders.keys():
    bottle.response.set_header("Cache-Control", respheaders["Cache-Control"])

  temp = 'print' if view == "print" else 'index'
  return bottle.template(temp, results=results,
    query=query, category_filter=category_filter, title=title,
    error=error, stats=stats, category_list=category_list, view=view,
    timeframe=timeframe, metric=metric, entity=entity, google_tag=config.google_tag,
    page=page, page_size=page_size, totalcount=totalcount, pagelink=pagelink,
    querystring=bottle.request.query_string)


#     Author details page
@bottle.get('/authors/<id:int>')
@bottle.view('author_details')
def display_author_details(id):
  try:
    get = requests.get(f"{config.rxapi}/v1/authors/{id}")
    if get.status_code == 404:
      raise helpers.NotFoundError(id)
    # make sure the URL we ended at matches the URL we asked for:
    new_id = re.search('/(\d+)$', get.url)
    if new_id and len(new_id.groups()) > 0:
      try:
        new_id = int(new_id.group(1))
      except Exception:
        bottle.response.status = 500
        return {"error": "Server errror."}
      if new_id != id: # if we got redirected to a new URL
        return bottle.redirect(f"{config.host}/authors/{new_id}", 301)
    author = get.json()
  except helpers.NotFoundError as e:
    bottle.response.status = 404
    return e.message
  except ValueError as e:
    bottle.response.status = 500
    print(e)
    return {"error": "Server error."}

  distro = helpers.rxapi("/v1/data/distributions/author/downloads")
  download_distribution = distro["histogram"]
  averages = distro["averages"]
  stats = helpers.rxapi("/v1/data/stats")
  return bottle.template('author_details', author=author,
    download_distribution=download_distribution, averages=averages, stats=stats,
    google_tag=config.google_tag)

#     Paper details page
@bottle.get('/papers/<paper_id:path>')
@bottle.view('paper_details')
def display_paper_details(paper_id):
  try:
    paper = requests.get(f"{config.rxapi}/v1/papers/{paper_id}")
  except helpers.NotFoundError as e:
    bottle.response.status = 404
    return e.message
  except ValueError as e:
    bottle.response.status = 500
    print(e)
    return {"error": "Server error."}

  # make sure the URL we ended at matches the URL we asked for:
  new_id = re.search('/(\d+)$', paper.url)
  print(f'NEW ID IS {new_id}')
  if new_id and len(new_id.groups()) > 0:
    print("in here")
    try:
      new_id = str(new_id.group(1))
      paper_id = str(paper_id)
    except Exception:
      bottle.response.status = 500
      return {"error": "Server errror."}
    if new_id != paper_id: # if we got redirected to a new URL
      print(f"\n\nNEW ONE IS : |{new_id}| VS |{paper_id}|")
      print("redirecting")
      return bottle.redirect(f"{config.host}/papers/{new_id}", 301)

  paper = paper.json()
  traffic = helpers.rxapi(f"/v1/downloads/{paper_id}")["results"]
  distro = helpers.rxapi("/v1/data/distributions/paper/downloads")
  download_distribution = distro["histogram"]
  averages = distro["averages"]
  stats = helpers.rxapi("/v1/data/stats")
  return bottle.template('paper_details', paper=paper, traffic=traffic,
    download_distribution=download_distribution, averages=averages, stats=stats,
    google_tag=config.google_tag)

#     Annual results
@bottle.get('/top/<year:int>')
def topyear(year):
  error = ''
  respheaders = None
  results = None

  if year < 2013:
    error = "Lists currently available only for 2013 through 2018."
    bottle.response.status = 404

  try:
    results, respheaders = helpers.rxapi(f"/v1/top/{year}", headers=True)
  except Exception as e:
    print(e)
    error = f"Sorry&mdash;there was a problem retrieving the results: {e}"
    bottle.response.status = 500

  if respheaders is not None and "Cache-Control" in respheaders.keys():
    bottle.response.set_header("Cache-Control", respheaders["Cache-Control"])

  stats = helpers.rxapi("/v1/data/stats")

  yearstats = { # TODO: Put this in the API
    2013: {
      "papers": 109,
      "downloads": 17268
    },
    2014: {
      "papers": 886,
      "downloads": 311046
    },
    2015: {
      "papers": 1774,
      "downloads": 679159
    },
    2016: {
      "papers": 4718,
      "downloads": 2182836
    },
    2017: {
      "papers": 11342,
      "downloads": 3995108
    },
    2018: {
      "papers": 20050,
      "downloads": 5730324
    }
  }

  return bottle.template('top_year', results=results['results'],
    year=year, yearpapers=yearstats[year]['papers'], yeardownloads = yearstats[year]['downloads'],
    error=error, stats=stats, google_tag=config.google_tag)

@bottle.route('/privacy')
@bottle.view('privacy')
def privacy():
  stats = helpers.rxapi("/v1/data/stats")
  return bottle.template("privacy", google_tag=config.google_tag, stats=stats)

@bottle.route('/about')
@bottle.view('privacy')
def privacy():
  stats = helpers.rxapi("/v1/data/stats")
  return bottle.template("about", google_tag=config.google_tag, stats=stats)

@bottle.route('/docs')
@bottle.view('api_docs')
def api_docs():
  stats = helpers.rxapi("/v1/data/stats")
  documentation = docs.build_docs()
  return bottle.template("api_docs", google_tag=config.google_tag, stats=stats, docs=documentation)

@bottle.route('/healthcheck')
@bottle.view('healthcheck')
def privacy():
  return bottle.template("healthcheck")

# Search engine stuff
@bottle.route(f'/{config.google_validation_file}')
def callback():
  return bottle.static_file(filename=config.google_validation_file, root='./static/')
@bottle.route('/robots.txt')
def callback():
  return bottle.static_file(filename='robots.txt', root='./static/')
@bottle.route('/favicon.ico')
def callback():
  return bottle.static_file(filename='favicon.ico', root='./static/')

# ---- Errors
@bottle.error(404)
@bottle.view('error')
def error404(error):
  return bottle.template("error", google_tag=config.google_tag)

@bottle.error(500)
@bottle.view('error')
def error500(error):
  return bottle.static_file('500.html', root='./static/')

# - SERVER -
@bottle.route('/static/<path:path>')
def callback(path):
  return bottle.static_file(path, root='./static/')

if config.use_prod_webserver:
  bottle.run(host='0.0.0.0', port=80, server="gunicorn")
else:
  bottle.run(host='0.0.0.0', port=80, debug=True, reloader=True)
