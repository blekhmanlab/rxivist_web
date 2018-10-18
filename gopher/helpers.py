import requests

import config

def render_searchmenu(gopher, results):
  components = []
  for paper in results["results"]:
    components.append(
      gopher.menu.info("{} tweets:".format(paper["metric"]))
    )
    components.append(
      gopher.menu.submenu(paper["title"], "/papers/{}".format(paper["id"]))
    )
  return gopher.render_menu(*components)

def rxapi(uri):
  get = requests.get("{}{}".format(config.rxapi, uri))
  return get.json()