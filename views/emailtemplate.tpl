% import helpers
% import config

% abstract_length = 200

<!doctype html>
<html lang="en" ng-app="app">
  <head>
    <title>Rxivist: Popular biology pre-print papers ranked</title>
  </head>
  <body>
    <code>
      % for i, result in enumerate(results):
        &lt;p>&lt;strong>{{ i+1 }}:&lt;/strong> &lt;a href="{{ result['biorxiv_url'] }}">{{ result['title'] }}&lt;/a>&lt;br />
        % if len(result["authors"]) == 2:
          {{ result["authors"][0]["name"] }} &amp; {{ result["authors"][1]["name"] }}
        % else:
          {{ result["authors"][0]["name"] }}
        % end
        % if len(result["authors"]) > 2:
          et al.
        % end
        &lt;br />
        {{ helpers.formatDate(result["first_posted"]) }}, &lt;em>{{ helpers.formatCategory(result["category"]) }}&lt;/em>, &lt;strong>{{ helpers.formatNumber(result["metric"]) }} tweets&lt;/strong>&lt;/p>
        &lt;p>{{ (result["abstract"][:abstract_length] + "...") if len(result["abstract"]) > abstract_length else result["abstract"] }}&lt;/p>
      % end
    </code>
  </body>
</html>