% import config
% import helpers
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: About</title>
  </head>

  <body>
    <div class="container" id="main">


      <div class="row">
        <div class="col-lg-9">
          % include("components/header")

          <h1>About</h1>
          <p>Rxivist indexes and sorts metadata from <a href="https://www.biorxiv.org/" target="_blank">bioRxiv</a> and <a href="https://www.medrxiv.org/" target="_blank">medRxiv</a>, <a href="http://www.sciencemag.org/news/2017/09/are-preprints-future-biology-survival-guide-scientists" target="_blank">preprint</a> servers<sup>1</sup> operated by Cold Spring Harbor Laboratory. There is no official association between CSHL and this project.

          <p><strong>Papers about the Rxivist project:</strong>
          <ul>
            <li><a href="https://elifesciences.org/articles/45133" target="_blank">Tracking the popularity and outcomes of all bioRxiv preprints</a>. <em>eLife</em>. doi: <code>10.7554/eLife.45133</code>.
            <li><a href="https://doi.org/10.1371/journal.pbio.3000269" target="_blank">Rxivist.org: Sorting biology preprints using social media and readership metrics</a>. <em>PLOS Biology</em>. doi: <code>10.1371/journal.pbio.3000269</code>.
          </ul>

          <p>Twitter data used on the front page is provided by <a href="https://www.crossref.org" target="_blank">Crossref</a>.
          % if config.display_altmetric:
            Social media interaction data displayed on preprint detail pages is provided by <a href="https://www.altmetric.com/">Altmetric</a>.
          % end

          <p>Rxivist is developed and maintained by the <a href="http://blekhmanlab.org">Blekhman Lab</a> at the <a href="https://cbs.umn.edu/academics/departments/gcd" target="_blank">University of Minnesota</a>. Its source code is available on GitHub in two locations, for <a href="https://github.com/blekhmanlab/rxivist" target="_blank">the API</a> and <a href="https://github.com/blekhmanlab/rxivist_web" target="_blank">this web application</a>. Its main components are:
          <ul>
            <li><a href="https://python.org" target="_blank">Python 3</a>, the <a href="https://bottlepy.org/" target="_blank">Bottle</a> web framework and the <a href="https://html.python-requests.org/" target="_blank">Requests-HTML</a> module (for web crawling)
            <li><a href="https://www.postgresql.org/" target="_blank">PostgreSQL</a> database and the <a href="http://initd.org/psycopg/docs/index.html" target="_blank">Psycopg</a> SDK
            <li><a href="https://docker.com/" target="_blank">Docker</a> containerization
            <li><a href="https://getbootstrap.org" target="_blank">Bootstrap</a> display elements
            <li><a href="http://chartjs.org/" target="_blank">Chart.js</a> data visualization
          </ul>
          <p>You can also browse a text-only version of this application at <code>gopher://origin.rxivist.org</code> from a Gopher-enabled<sup>2</sup> browser such as <a href="http://brewformulas.org/Lynx" target="_blank">Lynx</a> or an HTTP proxy like the one <a href="https://gopher.floodgap.com/gopher/gw?a=gopher%3A%2F%2Forigin.rxivist.org" target="_blank">hosted by Floodgap Systems</a>.

          <h2>Coverage of Rxivist</h2>
          <div class="row">
            <div class="col-4">
              <a href="https://www.nature.com/articles/d41586-019-00199-6" target="_blank"><img src="/static/nature.png" class="img-fluid" alt="Nature"></a>
            </div>
            <div class="col-4">
              <a href="https://prelights.biologists.com/highlights/tracking-the-popularity-and-outcomes-of-all-biorxiv-preprints/" target="_blank"><img src="/static/prelights.png" class="img-fluid" alt="Prelights"></a>
            </div>
            <div class="col-4">
              <a href="http://science.sciencemag.org/content/363/6424/208" target="_blank"><img src="/static/science.png" class="img-fluid" alt="NaturSciencee"></a>
            </div>
          </div>
          <br>
          <h2>Data notes</h2>
          <div class="row">
            <div class="col-12">
              <ul>
                <li>"All-time" Twitter metrics (from <a href="https://crossref.org">Crossref</a>) currently <strong>date back to February 2017</strong>. This is pulled from a different source than Altmetric, so their totals will likely be different.
                <li>Download metrics are <strong>updated for each paper about once every two weeks</strong>, which means there may be a discrepency between the totals reported by the preprint servers and the totals reported here.
              </ul>
            </div>
          </div>

          <hr>
          <ol>
            <li>For an overview of the common questions raised regarding preprints, see <a href="https://www.pnas.org/content/112/44/13439#sec-16" target="_blank">this Q&A</a> from preprint advocate <a href="http://asapbio.org/about-2" target="_blank">Ronald D. Vale</a>.
            <li>The Gopher protocol was a precursor to HTTP and the World Wide Web, <a href="https://en.wikipedia.org/wiki/Gopher_(protocol)" target="_blank">developed at UMN</a> in the early 1990s.
          </ol>
        </div>

        % include("components/sidebar")
      </div>
    </div>

    %include("components/footer")

  </body>
</html>
