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
        &lt;p>&lt;strong>{{ i+1 }}:&lt;/strong> &lt;a href="https://doi.org/{{ result['doi'] }}">{{ result['title'] }}&lt;/a>&lt;br />
        % if len(result["authors"]) > 4:
          {{ result["authors"][0]["name"] }},
          {{ result["authors"][1]["name"] }}
          &hellip;
          {{ result["authors"][-2]["name"] }},
          {{ result["authors"][-1]["name"] }}
        % else:
          % for i in range(0,len(result["authors"])):
            {{ result["authors"][i]["name"] }}{{ ',' if i < len(result["authors"]) - 1 else '' }}
          % end
        % end
        &lt;br />
        {{ helpers.formatDate(result["first_posted"]) }}, &lt;em>{{ helpers.formatCategory(result["category"]) }}&lt;/em>, &lt;strong>{{ helpers.formatNumber(result["metric"]) }} tweets&lt;/strong>&lt;/p>
        &lt;p>{{ (result["abstract"][:abstract_length] + "...") if len(result["abstract"]) > abstract_length else result["abstract"] }}&lt;/p>
      % end
    </code>
  </body>
</html>