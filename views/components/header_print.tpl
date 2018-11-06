% import helpers
<div class="row" id="header">
  <div class="col" style="text-align: center;">
    <a href="/"><img src="/static/rxivist_logo.png" class="img-fluid" alt="Rxivist logo" title="It's pronounced 'Archivist.'" width="350"></a>
  </div>
</div>
<div class="col-lg-8 offset-lg-2" style="text-align: center;">
  <p><em>rxivist.org combines preprints from <strong>bioRxiv.org</strong> with data from Twitter to help you <strong>find the papers being discussed</strong> in your field.
  <br>Currently indexing <strong>{{ helpers.formatNumber(stats["papers_indexed"]) }} bioRxiv papers</strong> from <strong>{{ helpers.formatNumber(stats["authors_indexed"]) }} authors</strong>.</em>
</div>
