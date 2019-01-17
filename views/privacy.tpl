% import helpers
<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist privacy policy</title>
  </head>

  <body>
    <div class="container" id="main">
      <div class="row">
        <div class="col-lg-9">
          % include("components/header")

          <h1>Privacy Policy</h1>
          <h2>Visitor data</h2>
            <p>Rxivist.org does not collect any information about its users that is not incidentally captured by server access logs.
            <p>We do use Google Analytics (with all demographic collection features disabled) to better understand how visitors use our site. Google has published details of <a href="https://policies.google.com/privacy">how they use this data</a> if you would like to review details of their privacy and compliance measures.
            <p>Newsletter sign-ups are stored by MailChimp and are not shared with any outside organizations.

          <h2>Content</h2>
            <p>Rxivist builds profiles of papers and authors using only content pulled directly from <a href="https://biorxiv.org">bioRxiv</a>. If we have erroneously interpreted the data, or have problematically outdated information about a paper or author, please contact Richard Abdill at <strong>rxivist@umn.edu</strong>.
        </div>
        % include("components/sidebar")
      </div>
    </div>

    %include("components/footer")

  </body>
</html>