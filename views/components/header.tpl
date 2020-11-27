% import config

<div class="row">
  <div class="col-md-6" style="padding-bottom: 35px;">
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
    <div class="col-md-6">
      <p>Rxivist combines biology preprints from <a href="https://biorxiv.org" target="_blank">bioRxiv</a> and <a href="https://medrxiv.org" target="_blank">medRxiv</a> with data from Twitter to help you <strong>find the papers being discussed</strong> in your field. Currently indexing <strong>{{ helpers.formatNumber(stats["papers_indexed"]) }} papers</strong> from <strong>{{ helpers.formatNumber(stats["authors_indexed"]) }} authors</strong>.
      <br>
      <span class="social-logo"><a href="{{ config.repo }}" target="_blank"><img src="/static/github.png" ></a></span>
      % if config.twitter is not None and config.twitter != "":
        <span class="social-logo"><a href="https://twitter.com/{{ config.twitter }}" target="_blank"><img src="/static/twitter.png"></a></span>
      % end
    </div>
  % end
</div>