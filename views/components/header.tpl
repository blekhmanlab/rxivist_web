% import helpers
<div class="row" id="header">
  <div class="col-md-6" style="padding-left: 35px;">
    <a href="/"><img src="/static/rxivist_logo.png" class="img-fluid" alt="Rxivist logo" title="It's pronounced 'Archivist.'" width="350"></a>
    <div style="padding: 15px 90px 0 15px;">
      <p>Rxivist combines preprints from <a href="https://biorxiv.org" target="_blank">bioRxiv</a> with data from Twitter to help you <strong>find the papers being discussed in your field</strong>.
    </div>
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
    <div class="col-lg-6">
      <ul>
        <li>Currently indexing <strong>{{ helpers.formatNumber(stats["papers_indexed"]) }} bioRxiv papers</strong> from <strong>{{ helpers.formatNumber(stats["authors_indexed"]) }} authors</strong>
        <li><a href="/">Home</a>
        <li><a href=
          % if entity == "papers":
            "/?entity=authors&category={{"" if len(category_filter) == 0 else category_filter[0]}}">Author leaderboards
          % else:
            "/?category={{"" if len(category_filter) == 0 else category_filter[0]}}">Paper search
          % end
        </a>
        <li><a href="/docs">API documentation</a>
        <li><a href="#" data-toggle="modal" data-target="#about">About the project</a><br>
        <span class="social-logo"><a href="https://www.github.com/rabdill/rxivist" target="_blank"><img src="/static/github.png" ></a></span>
        <span class="social-logo"><a href="https://twitter.com/rxivist" target="_blank"><img src="/static/twitter.png"></a></span>
      </ul>
      <div class="col-sm-12">
        <div class="alert alert-primary" role="alert">
          <strong><a href="*tk">The Rxivist preprint</a></strong> is now available for download from bioRxiv!
        </div>
      </div>
    </div>
  % end

</div>
