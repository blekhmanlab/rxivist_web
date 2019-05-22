import os

announcement = ''
# possible values for announcement_class:
# primary secondary success danger warning
# colors: https://getbootstrap.com/docs/4.3/components/alerts/
announcement_class = 'success'

# Hostname and protocol for the Rxivist API
rxapi = "http://api_url_goes_here.org"
# Whether to launch the application with gunicorn as the web server, or
# with Bottle's default. The default can be handy for development because
# it includes the option to reload the application any time there is a
# code change.
use_prod_webserver = True

# How many tweets should a paper accumulate in a day to earn a little
# fire icon next to its entry in the list?
hot_tweetcount = 110

# Maximum time, in seconds, that the front page can be cached
front_page_cache = 600

# Hostname where users will find your site.
# This is needed to build redirect URLs that don't
# break when the web server is behind a reverse proxy.
host = "http://url_goes_here.org"

# Repository listing all DB dumps available for download:
zenodohome = "https://doi.org/10.5281/zenodo.123456" # EXAMPLE VALUE

# Endpoint to send newsletter signup requests.
# Set to an empty string to disable.
mailchimp_post = "https://rxivist.us20.list-manage.com/subscribe/post?u=c273a6689e7b42e4355a1af54&amp;id=6b93ccc8c8"

# PLEASE NOTE: If you are planning to deploy this web application publicly,
# you need permission from Altmetric to incorporate their "attention score"
# information. See https://api.altmetric.com/embeds.html for more information.
display_altmetric = False

# Link to a form to provide feedback on the website
feedback = "https://docs.google.com/forms/d/e/1FAIpQLSfFRRtEYTnhB9XPbG4lat76zdD5CJRpnR_--xGg7WkVTDXl5Q/viewform?usp=sf_link"

repo = "https://github.com/blekhmanlab/rxivist"
twitter = "twitter_handle_here"

# The entity ID provided by Google Analytics
google_tag = "UA-tag_goes_here"
# The validation file provided by the Google Webmaster Tools.
# (Should be placed in the /static directory)
google_validation_file = "google_filename_goes_here.html"
