% import config
<div class="container">
  <div class="row" id="footer">
    <div class="col-sm-12">
      <p>
      % if config.feedback is not None and len(config.feedback) > 0:
        <a href="{{ config.feedback }}" target="_blank">Feedback</a> |
      % end
      <a href="/privacy">Privacy</a> | <a href="/about">About</a>
    </div>
  </div>
</div>

<script src="/static/jquery-3.3.1.slim.min.js"></script>
<script src="/static/popper.min.js"></script>
<script src="/static/bootstrap.min.js"></script>