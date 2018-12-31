% import helpers
<!doctype html>
<html lang="en" ng-app="app">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Most popular preprints of {{year}} – Rxivist</title>
  </head>
  <body>
    <div class="container" id="main">
      % include("components/header", stats=stats)
      <div class="row">
        <div class="col">
          % if error != "":
            <div class="alert alert-danger" role="alert" style="display: {{"none" if error == "" else "block"}}">
              {{error}}
            </div>
          % else:
            <h2>Most downloaded bioRxiv preprints of {{ year }}</h2>
            <p><em>There were {{ helpers.formatNumber(yearpapers) }} manuscripts posted to <a href="https://www.biorxiv.org" target="_blank">biorxiv.org</a> in {{ year }}, downloaded {{ helpers.formatNumber(yeardownloads) }} times. Below are the 25 preprints posted in {{ year }} that got the most downloads in that year.

            <p>Lists of the most popular preprints are available for <a href="/top/2013">2013</a>, <a href="/top/2014">2014</a>, <a href="/top/2015">2015</a>, <a href="/top/2016">2016</a>, <a href="/top/2017">2017</a> and <a href="/top/2018">2018</a>.</em>

            % if len(results) > 0:
              % include("components/results_annual", results=results)
            % end
          % end
        </div>
      </div>
    </div>

    %include("components/footer")

    <script>
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    </script>
  </body>
</html>