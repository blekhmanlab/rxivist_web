% import config
<div class="col-lg-{{width}}">
  <h4 class="text-secondary">{{result["title"]}}</h3>
  <div>
    <p><em>
      % if len(result["authors"]) > 1:
        {{ result["authors"][0]["name"] }}, {{ result["authors"][1]["name"] }}
      % else:
        {{ result["authors"][0]["name] }}
      % end
      % if len(result["authors"]) > 2:
        et al.
      % end
    </em></p>
    <p>{{ helpers.formatNumber(result["metric"]) }} {{ "downloads" if metric == "downloads" else "tweets"}} (posted {{ helpers.formatDate(result["first_posted"]) }})
    % if len(category_filter) != 1 and result["category"] != "unknown":
      <span class="badge {{ result["category"].replace("-", "") }}" style="margin-left: 10px;">{{ helpers.formatCategory(result["category"]) }}</span>
    % end

    % if result["abstract"] is not None:
      % abstract_length = 525 if width < 7 else 3000
      <p>{{ (result["abstract"][:abstract_length] + "...") if len(result["abstract"]) > abstract_length else result["abstract"] }}
    % else:
      <p><em>Paper abstract not yet indexed.</em>
    % end
     <p><a href="/papers/{{ result["id"] }}"><code>{{config.base_url}}/papers/{{ result["id"] }}</code></a><br>
       <a href="https://doi.org/{{ result["doi"] }}"><code>https://doi.org/{{ result["doi"] }}</code></a>
  </div>
</div>