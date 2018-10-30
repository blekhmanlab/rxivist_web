<div class="col-md-{{width}}">
  <h3><a href="/papers/{{result["id"]}}">{{result["title"]}}</a></h3>
  <div>
    <p><em>
      % if len(result["authors"]) > 1:
        {{ result["authors"][0]["name"] }}, {{ result["authors"][1]["name"] }}
      % end
      % if len(result["authors"]) > 2:
        et al.
      % end
    </em> (posted {{ helpers.formatDate(result["first_posted"]) }})</p>
    <p>{{ helpers.formatNumber(result["metric"]) }} {{ "downloads" if metric == "downloads" else "tweets"}}
    % if len(category_filter) != 1 and result["category"] != "unknown":
      <span class="badge {{ result["category"].replace("-", "") }}" style="margin-left: 10px;">{{ helpers.formatCategory(result["category"]) }}</span>
    % end

    <p>{{ (result["abstract"][:525] + "...") if len(result["abstract"]) > 525 else result["abstract"] }}
    <p><a href="{{result["url"]}}" target="_blank" class="btn btn-altcolor " role="button">view paper</a>
  </div>
</div>