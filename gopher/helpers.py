import requests

import config

def render_searchmenu(gopher, results):
  components = []
  if results["query"]["metric"] == "downloads":
      unit = "download"
  elif results["query"]["metric"] == "twitter":
    unit = "tweet"
  for paper in results["results"]:
    printunit = unit
    if paper["metric"] > 1:
      printunit += "s"
    components.append(
      gopher.menu.info("{} {}:".format(paper["metric"], printunit))
    )
    components.append(
      "0{}\t/papers/{}\t{}\t70".format(paper["title"], paper["id"], config.host)
    )
  return gopher.render_menu(*components)

def rxapi(uri):
  get = requests.get("{}{}".format(config.rxapi, uri))
  return get.json()