% import helpers
<div style="text-align: center;">
  <div class="row">
    <div class="col-lg-12">
      <a href="/"><img src="/static/rxivist_logo.png" class="img-fluid" alt="Rxivist logo" title="It's pronounced 'Archivist.'" width="350"></a>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-8 offset-lg-2">
      <p><em>Rxivist.org combines preprints from <strong>bioRxiv</strong> and <strong>medRxiv</strong> with data from Twitter to help you <strong>find the papers being discussed</strong> in your field.
      <br>Currently indexing <strong>{{ helpers.formatNumber(stats["papers_indexed"]) }} papers</strong> from <strong>{{ helpers.formatNumber(stats["authors_indexed"]) }} authors</strong>.</em>
    </div>
  </div>
</div>