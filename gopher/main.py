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

@app.route('/papers/<id>')
def paper(id):
  results = helpers.rxapi("/v1/papers/{}".format(id))
  return flask.render_template('paper_details.gopher', results=results)

@app.route('/about')
def about():
  return flask.render_template('about.gopher')

if __name__ == '__main__':
  app.run('0.0.0.0', 70, request_handler=GopherRequestHandler, debug=True)
