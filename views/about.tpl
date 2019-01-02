% import helpers
% import config
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: About</title>
  </head>

  <body>
    <div class="container" id="main">

      %include("components/header")

      <div class="row">
        <div class="col">
          <h1>About</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <p>Rxivist indexes and sorts metadata from <a href="https://www.biorxiv.org/" target="_blank">bioRxiv</a>, a <a href="http://www.sciencemag.org/news/2017/09/are-preprints-future-biology-survival-guide-scientists" target="_blank">preprint</a> server<sup>1</sup> operated by Cold Spring Harbor Laboratory. There is no official association between bioRxiv and this project.
          % if config.paper_url != "":
            A preprint about Rxivist is <a href="{{ config.paper_url }}" target="_blank">now available on bioRxiv</a>.
          % end

          <p>Social media information and publication metadata is provided by <a href="https://www.crossref.org" target="_blank">Crossref</a>.

          <p>Rxivist was developed in 2018 by the <a href="http://blekhmanlab.org">Blekhman Lab</a> at the <a href="https://cbs.umn.edu/academics/departments/gcd" target="_blank">University of Minnesota</a>. Its source code is available on GitHub in two locations, for <a href="https://github.com/blekhmanlab/rxivist" target="_blank">the API</a> and <a href="https://github.com/blekhmanlab/rxivist_web" target="_blank">this web application</a>. Its main components are:
          <ul>
            <li><a href="https://python.org" target="_blank">Python 3</a>, the <a href="https://bottlepy.org/" target="_blank">Bottle</a> web framework and the <a href="https://html.python-requests.org/" target="_blank">Requests-HTML</a> module (for web crawling)
            <li><a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a> database and the <a href="http://initd.org/psycopg/docs/index.html" target="_blank">Psycopg</a> SDK
            <li><a href="https://docker.com/" target="_blank">Docker</a> containerization
            <li><a href="https://getbootstrap.org" target="_blank">Bootstrap</a> display elements
          </ul>
          <p>You can also browse a text-only version of this application at <code>gopher://origin.rxivist.org</code> from a Gopher-enabled<sup>2</sup> browser such as <a href="http://brewformulas.org/Lynx" target="_blank">Lynx</a> or an HTTP proxy like the one <a href="https://gopher.floodgap.com/gopher/gw?a=gopher%3A%2F%2Forigin.rxivist.org" target="_blank">hosted by Floodgap Systems</a>.

          <hr>
          <ol>
            <li>For an overview of the common questions raised regarding preprints, see <a href="https://www.pnas.org/content/112/44/13439#sec-16" target="_blank">this Q&A</a> from preprint advocate <a href="http://asapbio.org/about-2" target="_blank">Ronald D. Vale</a>.
            <li>The Gopher protocol was a precursor to HTTP and the World Wide Web, <a href="https://en.wikipedia.org/wiki/Gopher_(protocol)" target="_blank">developed at UMN</a> in the early 1990s.
          </ol>
        </div>
      </div>
    </div>

    %include("components/footer")

  </body>
</html>