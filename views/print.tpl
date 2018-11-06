% import helpers
<!doctype html>
<html lang="en" ng-app="app">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: Popular biology pre-print papers ranked</title>
  </head>
  <body>
    <div class="container" id="main">
     % include("components/header_print", stats=stats)

      <div class="row">
        <div class="col">
          % if error != "":
            <div class="alert alert-danger" role="alert" style="display: {{"none" if error == "" else "block"}}">
              {{error}}
            </div>
          % else:
            %if len(results) == 0:
              <div><h3>No results found for "{{ query.replace("&", " ") }}"</h3></div>
            %else:
              <h2>{{title}}</h2>
            %end
            %if len(category_filter) > 0:
              <h4 style="padding-left: 20px;">in categor{{ "ies:" if len(category_filter) > 1 else "y" }}
                % for i, cat in enumerate(category_filter):
                  {{ helpers.formatCategory(cat) }}{{", " if i < (len(category_filter)-1) else ""}}
                %end
              </h4>
            %end
            % if len(results) == 0 and metric == "twitter":
            %  # just adding a new "metric" param at the end of the query string overrides
            %  # any that appear earlier in the query, once bottle gets it
              <div><p>Search was based on articles with Twitter activity data&mdash;redo search <a href="/?{{querystring}}&timeframe=alltime&metric=downloads">with download data</a> instead?</p></div>
            % end

            % if len(results) > 0:
              % include("components/results_news", results=results)
            % end
          % end  # end of conditional for "display this if there's no error"
        </div>
      </div>
    </div>
  </body>
</html>