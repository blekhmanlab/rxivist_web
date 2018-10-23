import os

# Hostname and protocol for the Rxivist API
rxapi = "http://api_url_goes_here.org"
# Whether to launch the application with gunicorn as the web server, or
# with Bottle's default. The default can be handy for development because
# it includes the option to reload the application any time there is a
# code change.
use_prod_webserver = True

# Hostname where users will find your site.
# This is needed to build redirect URLs that don't
# break when the web server is behind a reverse proxy.
host = "http://url_goes_here.org"

# HTML file listing all DB dumps available for download:
s3buckethome = "https://s3.amazonaws.com/bucket_name_here/index.html"

# Project-specific variables that get pulled into the documentation
paper_url = "*tk"
paper_title = "*tk"
repo = "https://github.com/blekhmanlab/rxivist"
twitter = "twitter_handle_here"

# The entity ID provided by Google Analytics
google_tag = "UA-tag_goes_here"
# The validation file provided by the Google Webmaster Tools.
# (Should be placed in the /static directory)
google_validation_file = "google_filename_goes_here.html"
