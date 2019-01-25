<div class="accordion" id="alltime">
  % for i, result in enumerate(results):
    <div>
      % if i < 3 and year > 2014:
        <div style="text-align: center;">
          <a href="https://doi.org/{{ result["doi"] }}" target="_blank"><img class="img-fluid" src="/static/figures/{{ result["id"] }}.png"></a>
        </div>
      % end
      <h3><strong>{{ i+1 }}:</strong>
      {{ result["title"] }}</h3>
      <em>
        % if len(result["authors"]) > 1:
          {{ result["authors"][0]["name"] }}, {{ result["authors"][1]["name"] }}
        % else:
          {{ result["authors"][0]["name"] }}
        % end
        % if len(result["authors"]) > 2:
          et al.
        % end
      </em><br>

      <div class="float-right">
        <a href="/papers/{{ result["id"] }}" class="btn btn-altcolor " role="button">more details</a>
        <a href="https://doi.org/{{ result["doi"] }}" target="_blank" class="btn btn-altcolor " role="button">view paper</a>
      </div>

      <strong>{{ helpers.formatNumber(result["metric"]) }}</strong>
      <small>downloads in the year</small>
      <br><small>Posted to bioRxiv {{ helpers.formatDate(result["first_posted"]) }}</small>
      % if result["category"] != "unknown":
        <a href="/?metric=downloads&timeframe=alltime&category={{result["category"]}}"><span class="badge catbutton {{ result["category"].replace("-", "") }}" style="margin-left: 10px;">{{ helpers.formatCategory(result["category"]) }}</span></a>
      % end
      <p style="padding-top: 10px;"><strong>Abstract:</strong> {{result["abstract"]}}
    </div>
    <hr><br>
  % end
</div>
