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
    <li><a href="/top/2018">Top preprints of 2018</a>
    <li><a href=
      % if entity == "papers":
        "/?entity=authors&category={{"" if len(category_filter) == 0 else category_filter[0]}}">Author leaderboards
      % else:
        "/?category={{"" if len(category_filter) == 0 else category_filter[0]}}">Paper search
      % end
    </a>
    <li><a href="/docs">The API</a>
    <li><a href="/about">About the project</a>
    <li><a href="/newsletter">Email newsletter</a>
    % if config.paper_url != "":
      <li><a href="{{ config.paper_url }}" target="_blank">Rxivist preprint</a>
    % end
  </ul>
  <hr>
  <!-- Begin Mailchimp Signup Form -->
  <div id="mc_embed_signup">
    <form action="https://rxivist.us20.list-manage.com/subscribe/post?u=c273a6689e7b42e4355a1af54&amp;id=6b93ccc8c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
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
</div>