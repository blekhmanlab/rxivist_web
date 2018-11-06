<div class="row" style="margin-top: 30px;">
  <div class="col-sm-2">&nbsp;</div>
  % include("components/results_news_lede", result=results[0], width=8)
</div>
<div class="row">
  % for i, result in enumerate(results):
    % if i % 2 == 0:
      </div><div class="row">
    % end
    % include("components/results_news_lede", result=result, width=6)
  % end
</div>