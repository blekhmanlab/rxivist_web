<p class="text-right"><em><strong>{{ "{:,}".format(totalcount) }} results found.</strong> For more information, click each entry to expand.</em></p>
<p class="text-left" style="margin-top: -2.7em;">
  <a href="{{pagelink}}0&view=news" alt="Printer-friendly front page">
    <i class="fas fa-print" style="font-size: 1.7em;"></i>
  </a>
</p>
<div class="accordion" id="alltime">
  % for i, result in enumerate(results):
    <div class="card">
      <div class="card-header context" id="heading{{result["id"]}}"  data-toggle="collapse" data-target="#collapse{{result["id"]}}" aria-expanded="true" aria-controls="collapse{{result["id"]}}">
        <strong>{{i+1 + (page * page_size)}}:</strong>
        % if metric == "twitter" and timeframe == "day" and result["metric"] > 80:
          <i class="fab fa-hotjar text-danger" style="font-size: 2em;"></i>
        % end
        {{result["title"]}}

        <br>
          <strong>{{ helpers.formatNumber(result["metric"]) }}</strong>
          % if metric == "downloads":
            <small>{{ "downloads" if result["metric"] > 1 else "download" }}</small>
          % elif metric == "twitter":
            <small>{{ "tweets" if result["metric"] > 1 else "tweet" }}</small>
          % end

        % if result["category"] != "unknown":
          <span class="badge {{ result["category"].replace("-", "") }}" style="margin-left: 10px;">{{ helpers.formatCategory(result["category"]) }}</span>
        % end

        <p class="text-right" style="margin-top: -1.5em; margin-bottom: 0;"><small>Posted to bioRxiv
          {{ helpers.formatDate(result["first_posted"]) }}
        </small></p>
      </div>
      <div id="collapse{{result["id"]}}" class="collapse" aria-labelledby="heading{{result["id"]}}" data-parent="#alltime">
        <div class="card-body">
          <div class="float-right">
            <a href="/papers/{{ result["id"] }}" class="btn btn-altcolor " role="button">more details</a>
            <a href="{{ result["biorxiv_url"] }}" target="_blank" class="btn btn-altcolor " role="button">view paper</a>
          </div>
          <p>
          % for i, author in enumerate(result["authors"]):
            <a href="/authors/{{ author["id"] }}">{{ author["name"] }}</a>{{", " if i < (len(result["authors"]) - 1) else ""}}
          % end

          <p>{{result["abstract"]}}
        </div>
      </div>
    </div>
  % end
</div>

%include("components/pagination")
