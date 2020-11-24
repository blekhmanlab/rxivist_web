% import config
% try:
%  entity
% except:
%  entity = None
%  category_filter = [] # if we don't have an entity type, we won't have a category filter
% end

<div class="col-lg-3">
  <ul>
    <li><a href="/">Home</a>
    <!--<li><a href="/top/2018">Top preprints of 2018</a>-->
    <li><a href="/?category={{"" if len(category_filter) == 0 else category_filter[0]}}">Paper search</a>
    <li><a href="/stats">Overall metrics</a>
    <li><a href="/docs">The API</a>
    <li><a href="https://doi.org/10.5281/zenodo.2529922">The dataset</a>
    % if config.mailchimp_post != "":
      <li><a href="/newsletter">Email newsletter</a>
    % end
    <li><a href="/about">About</a>
  </ul>
  <hr>
    <span style='font-family: Georgia; font-size: 1.2em;'><strong>Pan<i><font color="red">L</font></i>ingua</strong></span>
    <ul>
      <li><a href="https://panlingua.rxivist.org">Multi-lingual preprint search</a></li>
    </ul>
  <hr>
  % if config.mailchimp_post != "":
    <!-- Begin Mailchimp Signup Form -->
    <div id="mc_embed_signup">
      <form action="{{ config.mailchimp_post }}" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
        <div id="mc_embed_signup_scroll">
          <p><strong>Sign up for the Rxivist weekly newsletter!</strong> (<a href="/newsletter">Click here</a> for more details.)

          <input type="email" class="form-control" value="" name="EMAIL" class="required email" id="mce-EMAIL" placeholder="Enter email address here">

          <div id="mce-responses" class="clear">
            <div class="response" id="mce-error-response" style="display:none"></div>
            <div class="response" id="mce-success-response" style="display:none"></div>
          </div>
          <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
          <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_c273a6689e7b42e4355a1af54_6b93ccc8c8" tabindex="-1" value=""></div>
          <div style="text-align: center;">
            <input type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="btn btn-altcolor">
          </div>
        </div>
      </form>
    </div>
    <!--End mc_embed_signup-->
    <hr>
  % end
  <h2>News</h2>
  <ul>
    <li><strong>18 Dec 2019:</strong> We're pleased to announce <span style='font-family: Georgia;'><strong>Pan<i><font color="red">L</font></i>ingua</strong></span>, a new tool that enables you to <a href="https://panlingua.rxivist.org">search for machine-translated bioRxiv preprints</a> using more than 100 different languages.
    <li><strong>21 May 2019:</strong> <em>PLOS Biology</em> has published <a href="https://doi.org/10.1371/journal.pbio.3000269">a community page</a> about Rxivist.org and its design.
    <li><strong>10 May 2019:</strong> The paper analyzing the Rxivist dataset has been <a href="https://elifesciences.org/articles/45133">published at <em>eLife</em></a>.
    <li><strong>1 Mar 2019:</strong> We now have <a href="/stats">summary statistics</a> about bioRxiv downloads and submissions.
    <li><strong>8 Feb 2019:</strong> Data from <a href="https://altmetric.com">Altmetric</a> is now available on the Rxivist details page for every preprint. Look for the "donut" under the download metrics.
    <li><strong>30 Jan 2019:</strong> preLights has <a href="https://prelights.biologists.com/highlights/tracking-the-popularity-and-outcomes-of-all-biorxiv-preprints/" target="_blank">featured the Rxivist preprint</a> and written about our findings.
    <li><strong>22 Jan 2019:</strong> <em>Nature</em> just published <a href="https://www.nature.com/articles/d41586-019-00199-6" target="_blank">an article about Rxivist</a> and our data.
    <li><strong>13 Jan 2019:</strong> The <a href="https://doi.org/10.1101/515643" target="_blank">Rxivist preprint</a> is live!
  </ul>
</div>