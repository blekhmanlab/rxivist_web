% import config
% import helpers
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: {{paper["title"]}}</title>

    <meta name="twitter:card" content="summary"></meta>
    <meta property="og:title" content="Rxivist: {{paper["title"]}}" />
    <meta property="og:description" content="Usage stats for {{paper["title"]}} from the website that helps you find the preprints people are talking about." />
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

          <div class="row">
            <div class="col">
              <h1>{{paper["title"]}}</h1>
              <div>
                % if paper["category"] != "unknown":
                  <a href="/?metric=downloads&timeframe=alltime&category={{ paper['category'] }}" class="btn catbutton {{ paper["category"].replace("-", "") }}" role="button">{{ helpers.formatCategory(paper["category"]) }}</a>
                % end

                <a href="https://doi.org/{{ paper['doi'] }}" target="_blank" class="btn btn-altcolor " role="button">view on {{ helpers.formatRepo(paper["repo"]) }}</a>
                % if "publication" in paper.keys() and len(paper["publication"].keys()) > 0:
                  <a href="https://doi.org/{{ paper['publication']['doi'] }}" target="_blank" class="btn btn-warning" role="button">view in {{ "publication" if "journal" not in paper["publication"].keys() or paper["publication"]["journal"] == "" else paper["publication"]["journal"] }}</a>
                % end
              </div>
              <p>By
              % for i, coauthor in enumerate(paper["authors"]):
                <a href="/authors/{{ coauthor['id'] }}">{{ coauthor["name"] }}</a>{{", " if i < (len(paper["authors"]) - 1) else ""}}
              % end
              <em>
                % if ("first_posted" in paper.keys() and paper["first_posted"] != "") or ("ranks" in paper.keys() and paper["ranks"]["alltime"]["downloads"] is not None):
                  <p>
                % end
                % if "first_posted" in paper.keys() and paper["first_posted"] != "":
                  Posted <strong>{{ helpers.formatDate(paper["first_posted"]) }}</strong>
                % end
              </em>
              <br>{{ helpers.formatRepo(paper["repo"]) }} DOI: <strong>{{ paper["doi"] }}</strong>
              % if "publication" in paper.keys() and len(paper["publication"].keys()) > 0:
                (published DOI: <strong>{{ paper["publication"]["doi"] }}</strong>)
              % end
            </div>
          </div>
          <div class="row">
            <div class="col-md-6">
              <p>{{paper["abstract"]}}
            </div>
            <div class="col-md-6">
              <h4>Download data</h4>
              %include("components/paper_stats", paper=paper)
              % if config.display_altmetric:
                <h4>Altmetric data</h4>
                <div data-badge-details="right" data-badge-type="medium-donut" data-doi="{{ paper['doi'] }}" class="altmetric-embed"></div>
              % end
            </div>
          </div>
          % if "ranks" in paper.keys() and helpers.formatNumber(paper["ranks"]["alltime"]["rank"]) != "None":
            <div class="row">
              <div class="col-md-6">
                % if len(traffic) > 1:
                  <h3><br>Downloads over time</h3>
                  <canvas id="downloadsOverTime"></canvas>
                % end
              </div>
              <div class="col-md-6">
                <h3>Distribution of downloads per paper, site-wide</h3>
                <canvas id="downloadsDistribution"></canvas>
              </div>
              %include("components/download_distribution", entity=paper,  entity_name="paper", download_distribution=download_distribution, averages=averages)

              % include("components/graph_line",
              %   traffic = traffic,
              %   canvasID = 'downloadsOverTime',
              %   yaxis = 'Downloads')
            </div>
          % end
        </div>
        %include("components/sidebar")
      </div>
    </div>

    %include("components/footer")

  </body>
</html>