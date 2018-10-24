import requests

import config

def headermenu(gopher):
  return gopher.render_menu(
    f"1Most tweeted papers\t/search/twitter\t{config.host}\t70",
    f"1Most downloaded papers\t/search/downloads\t{config.host}\t70",
    f"0About\t/about\t{config.host}\t70"
  )

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
      gopher.menu.info(f'{paper["metric"]} {printunit}:')
    )
    components.append(f'0{paper["title"]}\t/papers/{paper["id"]}\t{config.host}\t70')
  return gopher.render_menu(*components)

def searchmenu1(gopher, metric, categories):
  components = [
    f"1All categories!\t/search/{metric}/all\t{config.host}\t70",
  ]
  for category in categories:
    components.append("1{0}\t/search/{1}/{0}\t{2}\t70".format(category, metric, config.host))
  return gopher.render_menu(*components)

def searchmenu2(gopher, metric, category, timeframes):
  components = []
  for t in timeframes:
    components.append("1{0}\t/search/{1}/{2}/{0}\t{3}\t70".format(t, metric, category, config.host))
  return gopher.render_menu(*components)
