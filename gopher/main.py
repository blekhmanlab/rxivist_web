import flask
from flask_gopher import GopherExtension, GopherRequestHandler
import requests

import config
import menus

def rxapi(uri):
  get = requests.get("{}{}".format(config.rxapi, uri))
  return get.json()

app = flask.Flask(__name__)
gopher = GopherExtension(app)

@app.route('/')
def index():
  results = rxapi("/v1/papers")
  results = menus.searchmenu0(gopher, results)
  headermenu = menus.headermenu(gopher)
  return gopher.render_menu_template('index.gopher',
    results=results, headermenu=headermenu)

@app.route('/search/<metric>')
def search1(metric):
  categories = rxapi("/v1/data/categories")
  categories = categories["results"]
  menu = menus.searchmenu1(gopher, metric, categories)
  return gopher.render_menu_template('choose_category.gopher',
    menu=menu, metric=metric)

@app.route('/search/<metric>/<category>')
def search2(metric, category):
  timeframes = ["alltime", "ytd", "lastmonth"] # downloads
  if metric == "twitter":
    timeframes = ["alltime", "day", "week", "month", "year"]

  menu = menus.searchmenu2(gopher, metric, category, timeframes)
  return gopher.render_menu_template('choose_timeframe.gopher',
    category=category, metric=metric, menu=menu)

@app.route('/search/<metric>/<category>/<timeframe>')
def search3(metric, category, timeframe):
  categories = rxapi("/v1/data/categories")
  categories = categories["results"]

  if metric not in ["twitter", "downloads"]:
    return "Invalid value specified for ranking metric"
  if category not in categories and category != "all":
    return "Invalid value specified for category"

  timeframes = ["alltime", "ytd", "lastmonth"] # downloads
  if metric == "twitter":
    timeframes = ["alltime", "day", "week", "month", "year"]
  if timeframe not in timeframes:
    return "Invalid value specified for timeframe"

  query = "/v1/papers?timeframe={}&metric={}".format(timeframe, metric)
  if category != "all":
    query += "&category={}".format(category)
  results = rxapi(query)
  results = menus.searchmenu0(gopher, results)

  return gopher.render_menu_template('results.gopher',
    results=results, category=category, metric=metric,
    timeframe=timeframe)

@app.route('/papers/<id>')
def paper(id):
  results = rxapi("/v1/papers/{}".format(id))
  return flask.render_template('paper_details.gopher', results=results)

@app.route('/about')
def about():
  return flask.render_template('about.gopher')

if __name__ == '__main__':
  app.run('0.0.0.0', 70, request_handler=GopherRequestHandler, debug=True)
