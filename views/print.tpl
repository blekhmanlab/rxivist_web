% import helpers
<!doctype html>
<html lang="en" ng-app="app">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: Popular biology pre-print papers ranked</title>
  </head>
  <body>
    <div id="main">
      % include("components/header_print", stats=stats)
      <div class="row">
        <div class="col-lg-12">
          % if error != "":
            <div class="alert alert-danger" role="alert" style="display: {{"none" if error == "" else "block"}}">
              {{error}}
            </div>
          % else:
            %if len(results) == 0:
              <div><h3>No results found for "{{ query.replace("&", " ") }}"</h3></div>
            %else:
              <h2 style="text-align: center;">{{title}}</h2>
              <p style="text-align: center;"><em>Results {{ 1 + (page * page_size) }} through {{ (page * page_size) + len(results) }} out of {{ totalcount }}</em>
            %end
            %if len(category_filter) > 0:
              <h4 style="padding-left: 20px;">in categor{{ "ies:" if len(category_filter) > 1 else "y" }}
                % for i, cat in enumerate(category_filter):
                  {{ helpers.formatCategory(cat) }}{{", " if i < (len(category_filter)-1) else ""}}
                %end
              </h4>
            %end
        </div>
      </div>
      <div class="row">
        <div class="col-lg-12">
            % if len(results) == 0 and metric == "twitter":
            %  # just adding a new "metric" param at the end of the query string overrides
            %  # any that appear earlier in the query, once bottle gets it
              <div><p>Search was based on articles with Twitter activity data&mdash;redo search <a href="/?{{querystring}}&timeframe=alltime&metric=downloads">with download data</a> instead?</p></div>
            % end
        </div>
      </div>
      % if len(results) > 0:
        <div class="row">
          <div class="col-sm-2">&nbsp;</div>
          % include("components/results_print_entry", result=results[0], width=8, rank=(1 + (page * page_size)))
        </div>
        <div class="row">
          % if len(results) > 1:
            % for i, result in enumerate(results[1:]):
              % if i % 2 == 0:
                </div><div class="row">
              % end
              % include("components/results_print_entry", result=result, width=6, rank=(i+2 + (page * page_size)))
            % end
          % end
        </div>
      % end
    % end  # end of conditional for "display this if there's no error"
    </div>
  </body>
</html>