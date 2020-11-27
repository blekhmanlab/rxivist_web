"""Utilities for interpreting data that arrives in impractical formats.

This module stores helper functions that transform data for the controllers.
"""
import config

import requests

class NotFoundError(Exception):
  def __init__(self, id):
    self.message = f"Entity could not be found with id {id}"

def get_traffic(connection, id):
  """Collects data about a single paper's download statistics.

  Arguments:
    - connection: a database connection object.
    - id: the ID given to the article being queried.
  Returns:
    - A two-element tuple. The first element is the number of views of
        the paper's abstract; the second is total PDF downloads.

  """

  traffic = connection.read("SELECT SUM(abstract), SUM(pdf) FROM article_traffic WHERE article=%s;", (id,))
  if len(traffic) == 0:
    raise NotFoundError(id)
  return traffic[0] # "traffic" is an array of tuples; we only want a tuple.

def num_to_month(monthnum):
  """Converts a (1-indexed) numerical representation of a month
  of the year into a three-character string for printing. If
  the number is not recognized, it returns an empty string.

  """
  monthnum = int(monthnum)

  months = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec"
  }
  if monthnum is None or monthnum < 1 or monthnum > 12:
    return ""
  return months[monthnum]

def formatDate(datestring):
  # yyyy-mm-dd to dd MMM yyyy
  x = datestring.split("-")
  if len(x) < 3:
    return ""
  return "{} {} {}".format(x[2], num_to_month(x[1]), x[0])

def formatCategory(cat):
  return cat.replace("-", " ")

def formatNumber(val):
  if val is None:
    return "None"
  return format(val, ",d")

def formatRepo(val):
  printables = {
    'biorxiv': 'bioRxiv',
    'medrxiv': 'medRxiv',
    'all': 'all'
  }
  return printables[val]

def findCategory(needle, haystack):
  for x in haystack:
    if x["category"] == needle:
      return x

def rxapi(uri, headers=False):
  # The "headers" flag controls whether the response headers are returned
  get = requests.get(
    "{}{}".format(config.rxapi, uri),
    headers={"Referer": "rxivist.org"}
  )
  if get.status_code == 404:
    raise NotFoundError(uri)
  if headers:
    return (get.json(), get.headers)
  return get.json()