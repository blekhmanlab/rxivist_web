% import helpers
% import config
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist: Newsletter</title>
  </head>

  <body>
    <div class="container" id="main">
      <div class="row">
        <div class="col-lg-9">
          % include("components/header")

          <h1>About the newsletter</h1>
          <p>Rxivist indexes and sorts metadata from <a href="https://www.biorxiv.org/" target="_blank">bioRxiv</a>. Rxivist allows users to sort preprints based on Twitter activity or download metrics across a number of categories and timeframes&mdash;our weekly newsletter brings <strong>a slice of this information to your email inbox every Friday</strong>: We'll send the top 20 <strong>most tweeted bioRxiv preprints of the week</strong>, with titles, snippets of abstracts, and links to read more.

          <p>The newsletter (and its formatting) is still a work in progress, so these specs may change. The main goal, however, will not: to help you <strong>find the most discussed preprints in the life sciences</strong>. You can <a href="https://us20.campaign-archive.com/home/?u=c273a6689e7b42e4355a1af54&id=6b93ccc8c8" target="_blank" title="View previous newsletters">view previous newsletters</a> to get an idea of what's on the way. If you think it's for you, <strong>sign up for free below</strong> or in the sidebar:

          <div id="mc_embed_signup">
            <form action="https://rxivist.us20.list-manage.com/subscribe/post?u=c273a6689e7b42e4355a1af54&amp;id=6b93ccc8c8" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
              <div id="mc_embed_signup_scroll">
                <div class="input-group mb-3 col-md-9">
                  <input type="email" class="form-control form-control-lg" value="" name="EMAIL" class="required email" id="mce-EMAIL" placeholder="Enter email address here">
                  <div class="input-group-append">
                    <button type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="btn btn-altcolor">Subscribe</button>
                  </div>
                </div>

                <div id="mce-responses" class="clear">
                  <div class="response" id="mce-error-response" style="display:none"></div>
                  <div class="response" id="mce-success-response" style="display:none"></div>
                </div>
                <!-- real people should not fill this in and expect good things - do not remove this or risk form bot signups-->
                <div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_c273a6689e7b42e4355a1af54_6b93ccc8c8" tabindex="-1" value=""></div>
              </div>
            </form>
          </div>
        </div>

        % include("components/sidebar")
      </div>
    </div>

    %include("components/footer")

  </body>
</html>