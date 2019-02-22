% import helpers
<!doctype html>
<html lang="en" ng-app="app">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>bioRxiv summary statistics – Rxivist</title>

    <meta name="twitter:card" content="summary"></meta>
    <meta property="og:title" content="bioRxiv summary metrics" />
    <meta property="og:description" content="Overall metrics on the bioRxiv corpus, from Rxivist, the website that helps you find the preprints people are talking about." />
    <meta property="og:image" content="https://rxivist.org/static/rxivist_r.png" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-annotation/0.5.5/chartjs-plugin-annotation.js"></script>
    <script src="https://cdn.rawgit.com/chartjs/Chart.js/master/samples/utils.js"></script>
    <script type='text/javascript' src='https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js'></script>
  </head>
  <body>
    <div class="container" id="main">
      <div class="row">
        <div class="col-lg-9">
          % include("components/header")
          % if error != "":
            <div class="alert alert-danger" role="alert" style="display: {{"none" if error == "" else "block"}}">
              {{error}}
            </div>
          % else:
            <h1>Overall bioRxiv metrics</h1>

            <h2>Monthly downloads</h2>
            <canvas id="monthlyDownloads"></canvas>
            % include("components/graph_line",
            %   traffic = results['downloads'],
            %   canvasID = 'monthlyDownloads',
            %   yaxis = 'Downloads')

            <p><em>Since per-paper download metrics are updated over time, a month's download count change up to four weeks after it ends.</em></p>


            <h2>Monthly submissions, overall</h2>

            <canvas id="monthlySubmissions"></canvas>
            % include("components/graph_line",
            %   traffic = results['submissions'],
            %   canvasID = 'monthlySubmissions',
            %   yaxis = 'Preprints posted')

            <p><em>See <a href="http://www.prepubmed.org/monthly_stats/">PrePubMed</a> for a similar chart that puts bioRxiv submissions in context alongside other preprint servers.</em></p>

            <h2>Monthly submissions, by category</h2>

            <canvas id="monthlySubmissionsCat"></canvas>
            % include("components/graph_stacked_bar",
            %   traffic = results['submissions_categorical'],
            %   canvasID = 'monthlySubmissionsCat',
            %   yaxis = 'Preprints posted',
            %   stacked = False)

            <p><em>The colors used in this plot are chosen randomly when the page loads. If you are having trouble seeing the lines, try refreshing the page.</em></p>

        </div>

        %include("components/sidebar")
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