import requests

import config

def headermenu(gopher):
  components = [
    "1Most tweeted papers\t/search/twitter\t{}\t70".format(config.host),
    "1Most downloaded papers\t/search/downloads\t{}\t70".format(config.host),
    "1About\t/about\t{}\t70".format(config.host)
  ]
  return gopher.render_menu(*components)

def searchmenu0(gopher, results):
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

def searchmenu1(gopher, metric, categories):
  components = [
    "1All categories!\t/search/{}/all\t{}\t70".format(metric, config.host),
  ]
  for category in categories:
    components.append("1{0}\t/search/{1}/{0}\t{2}\t70".format(category, metric, config.host))
  return gopher.render_menu(*components)

def searchmenu2(gopher, metric, category, timeframes):
  components = []
  for t in timeframes:
    components.append("1{0}\t/search/{1}/{2}/{0}\t{3}\t70".format(t, metric, category, config.host))
  return gopher.render_menu(*components)
