import os

rxapi = "https://api.rxivist.org"
# Whether to launch the application with gunicorn as the web server, or
# with Bottle's default. The default can be handy for development because
# it includes the option to reload the application any time there is a
# code change.
use_prod_webserver = True

# The entity ID provided by Google Analytics
google_tag = "UA-125076477-1" # TODO: put these in environment variables
# The validation file provided by the Google Webmaster Tools.
# (Should be placed in the /static directory)
google_validation_file = "google3d18e8a680b87e67.html" # TODO this one too
