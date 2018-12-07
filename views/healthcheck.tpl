% import helpers
<!doctype html>
<html lang="en" ng-app="app">
  <head>
    <title>Rxivist: Popular biology pre-print papers ranked</title>
  </head>
  <body>
    <div class="container" id="main">
      <div class="row">
        <div class="col">
          <h1>Healthcheck page</h1>
          If this won't load, nothing will
        </div>
      </div>
    </div>

    %include("components/footer")

    <script>
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    </script>
  </body>
</html>