import flask
from flask_gopher import GopherExtension, GopherRequestHandler

import helpers

app = flask.Flask(__name__)
gopher = GopherExtension(app)

@app.route('/')
def index():
  results = helpers.rxapi("/v1/papers")
  results = helpers.render_searchmenu(gopher, results)
  return gopher.render_menu_template('index.gopher', results=results)

@app.route('/search/<metric>')
def search1(metric):
  categories = helpers.rxapi("/v1/data/categories")
  categories = categories["results"]
  return gopher.render_menu_template('choose_category.gopher',
    categories=categories, metric=metric)

@app.route('/search/<metric>/<category>')
def search2(metric, category):
  timeframes = ["alltime", "ytd", "lastmonth"] # downloads
  if metric == "twitter":
    timeframes = ["alltime", "day", "week", "month", "year"]

  categories = helpers.rxapi("/v1/data/categories")
  categories = categories["results"]
  return gopher.render_menu_template('choose_timeframe.gopher',
    category=category, metric=metric, timeframes=timeframes)

@app.route('/search/<metric>/<category>/<timeframe>')
def search3(metric, category, timeframe):
  categories = helpers.rxapi("/v1/data/categories")
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
  results = helpers.rxapi(query)
  results = helpers.render_searchmenu(gopher, results)

  return gopher.render_menu_template('results.gopher',
    results=results, category=category, metric=metric,
    timeframe=timeframe)

@app.route('/papers/<id>')
def paper(id):
  results = helpers.rxapi("/v1/papers/{}".format(id))
  return gopher.render_menu_template('paper_details.gopher', results=results)

@app.route('/about')
def about():
  return flask.render_template('about.gopher')

if __name__ == '__main__':
  app.run('0.0.0.0', 70, request_handler=GopherRequestHandler, debug=True)
