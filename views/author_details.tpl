% import helpers
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>{{author["name"]}} author profile – Rxivist</title>
    <meta name="description" content="Research profile for
    % if "institution" in author.keys() and author["institution"] is not None:
      {{author["name"]}} ({{ author["institution"] }}),
    % else:
      {{author["name"]}},
    % end
    provided by Rxivist, the site that helps you find the most discussed biology preprints on the internet."/>

    <meta name="twitter:card" content="summary"></meta>
    <meta property="og:title" content="{{author["name"]}} on Rxivist" />
    <meta property="og:description" content="Research profile for {{author["name"]}} from the website that helps you find the preprints people are talking about." />
    <meta property="og:image" content="https://rxivist.org/static/rxivist_r.png" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-annotation/0.5.5/chartjs-plugin-annotation.js"></script>
    <script src="https://cdn.rawgit.com/chartjs/Chart.js/master/samples/utils.js"></script>
  </head>

  <body>
    <div class="container" id="main">
      <div class="row">
        <div class="col-lg-9">
          % include("components/header")
          <div class="row">
            <div class="col-sm-12">
              <h1>Author: {{author["name"]}}</h1>
              <ul>
                % if "orcid" in author.keys() and author["orcid"] is not None:
                  <li>ORCiD: <strong><a href="{{author["orcid"]}}" target="_blank">{{ author["orcid"] }}</a></strong>
                % end
                % if "institution" in author.keys() and author["institution"] is not None:
                  <li>Most recently observed institution: <strong>{{author["institution"]}}</strong>
                % end
              </ul>
            </div>
            <div class="col-sm-6">
              % if len(author["ranks"]) > 0:
                <h3>Rankings</h3>
              % end
              <ul>
                % alltime = helpers.findCategory("alltime", author["ranks"])
                % if alltime is not None:
                  <li>All-time downloads: {{ helpers.formatNumber(alltime["downloads"]) }} (rank: <strong>{{ helpers.formatNumber(alltime["rank"]) }}</strong>
                  %if alltime["tie"]:
                    (tie)
                  %end
                  out of {{ helpers.formatNumber(alltime["out_of"]) }})
                % end

                % if len(author["ranks"]) > 1:
                  <li>Categories:<ul>
                  % for entry in author["ranks"]:
                    % if entry["category"] == "alltime":
                    %   continue
                    % end
                    <li>{{ helpers.formatCategory(entry["category"]) }}: {{ helpers.formatNumber(entry["downloads"]) }} (rank: <strong>{{ helpers.formatNumber(entry["rank"]) }}</strong>
                    %if entry["tie"]:
                      (tie)
                    %end
                    out of {{ helpers.formatNumber(entry["out_of"]) }})
                  % end
                  </ul>
                % end
              </ul>
            </div>
            % if alltime is not None:
              <div class="col-md-6">
                <h3>Downloads per author, site-wide</h3>
                <canvas id="downloadsDistribution"></canvas>
              </div>
              %include("components/download_distribution", entity=author, entity_name="author", download_distribution=download_distribution, averages=averages)
            % end
          </div>
          <div class="row">
            <div class="col-md-12">
              <h2>Preprints</h2>
            </div>
            % for result in author["articles"]:
              <div class="col-md-6">
                <h2 style="font-size: 1.2em; padding-top: 20px; margin-bottom: 0;">{{result["title"]}}</h2>
                % if result["category"] != "unknown":
                  <a href="/?metric=downloads&timeframe=alltime&category={{result["category"]}}"><span class="badge btn-secondary" style="margin-left: 10px;">{{ helpers.formatCategory(result["category"]) }}</span></a>
                % end
                <a href="/papers/{{ result["id"] }}"><span class="badge btn-altcolor">more details</span></a>
                <a href="{{ result["biorxiv_url"] }}" target="_blank"><span class="badge btn-altcolor">view paper</span></a>
                %include("components/paper_stats", paper=result)
              </div>
            % end
          </div>
        </div>
        % include("components/sidebar")
      </div>
    </div>
    %include("components/footer")
    %include("components/modal_contact_caveats")
  </body>
</html>