% import helpers
% import config
<div class="row" id="header">
  <div class="col-lg-5" style="padding-left: 35px;">
    <a href="/"><img src="/static/rxivist_logo.png" class="img-fluid" alt="Rxivist logo" title="It's pronounced 'Archivist.'" width="350"></a>
  </div>
  % try:
  %  entity
  % except:
  %  entity = None
  %  category_filter = [] # if we don't have an entity type, we won't have a category filter
  % end
  % try:
  %  displaystats = stats
  % except:
  %  displaystats = False
  % end
  % if displaystats:
    <div class="col-lg-3">
      <ul>
        <li><a href="/">Home</a>
        <li><a href="/top/2018">Top preprints of 2018</a>
        <li><a href=
          % if entity == "authors":
            "/?category={{"" if len(category_filter) == 0 else category_filter[0]}}">Paper search
          % else:
            "/?entity=authors&category={{"" if len(category_filter) == 0 else category_filter[0]}}">Author leaderboards
          % end
        </a>
        <li><a href="/docs">The API</a>
        <li><a href="/about">About the project</a>
        % if config.paper_url != "":
          <li><a href="{{ config.paper_url }}" target="_blank">Rxivist preprint (NEW!)</a>
        % end
      </ul>
    </div>
    <div class="col-lg-4">
      <p>Rxivist combines preprints from <a href="https://biorxiv.org" target="_blank">bioRxiv</a> with data from Twitter to help you <strong>find the papers being discussed</strong> in your field. Currently indexing <strong>{{ helpers.formatNumber(stats["papers_indexed"]) }} bioRxiv papers</strong> from <strong>{{ helpers.formatNumber(stats["authors_indexed"]) }} authors</strong>.
      <br>
      <span class="social-logo"><a href="{{ config.repo }}" target="_blank"><img src="/static/github.png" ></a></span>
      % if config.twitter is not None and config.twitter != "":
        <span class="social-logo"><a href="https://twitter.com/{{ config.twitter }}" target="_blank"><img src="/static/twitter.png"></a></span>
      % end
    </div>
  % end

</div>
