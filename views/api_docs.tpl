% import helpers
% import config
% accordion_count = 0

<!doctype html>
<html lang="en">
  <head>
    %include("components/metadata.tpl", google_tag=google_tag)
    <title>Rxivist API Documentation</title>
  </head>

  <body>
    <div class="container" id="main">

      %include("components/header")

      <div class="row">
        <div class="col-sm-12">
          <h1>Rxivist API documentation</h1>
        </div>
        <div class="col-sm-10 offset-sm-1">
          <p><strong><a href="https://status.rxivist.org/">System health dashboard</a></strong>

          <p>The Rxivist API offers free, programmatic access to all of our bioRxiv metadata in a JSON interface. It's open to all&mdash;no keys or authentication here, at least for now. We do ask that you go easy on the requests, as this is a small project with limited funding for server infrastructure.

          <p>If you are looking for data to use offline somewhere, there's also no need to send 200,000 API requests to get all of it: <strong>We generate weekly database dumps that contain all Rxivist information,</strong> and you're welcome to download them. Not only is that easier for our servers to handle, but it may be much easier for you to process. The PostgreSQL dumps are available <a href="{{ config.s3buckethome }}">for direct download</a>.

          <p>If you are planning to use the Rxivist data within a web application, it would be much appreciated if you <strong>link to Rxivist</strong> on any page that displays a non-trivial amount of data pulled from this API.

          % if config.paper_url != "":
            If you use Rxivist data in your research, please cite our paper, <a href="{{ config.paper_url }}">"{{ config.paper_title }}."</a>
          % end

          Also, let us know what you're up to! We'd love to find out how this data is being used.

          <p>While we're talking about third-party web applications, we should here that <strong>we can't guarantee this API will be around forever</strong>. We plan to keep it running (and updated!) for the foreseeable future, but if you're going to build something using the Rxivist API that requires a strong uptime commitment or a concrete promise of long-term functionality, consider deploying your own version of <a href="{{ config.repo }}">the software</a>. We'll provide as much guidance as we can.

          <h3>Etiquette</h3>
            <p>We want to provide a free API for all, and we don't want to unnecessarily burden developers (or ourselves) with cumbersome API tokens or registration processes. For that to work, we ask that you be polite and try not to do anything that will take the API down or otherwise make it unusable for others. Specifically, we encourage the following polite behaviour:

            <ul>
              <li>Cache data so you don't request the same information over and over again.
              <li>Minimize the number of parallel requests being made. If you start noticing increased response times or start getting timeout errors, consider adding pauses between requests.
              <li>Specify a User-Agent header that properly identifies your script or tool and that provides a means of contacting you via email using "mailto:". For example: <code>GroovyBib/1.1 (https://example.org/GroovyBib/; mailto:GroovyBib@example.org) BasedOnFunkyLib/1.4</code>. This way we can contact you if we see a problem.
              <li>Report problems and/or ask questions on <a href="{{ config.repo }}/issues">our issue tracker</a>.
            </ul>

            <p>Alas, not all people are polite. And for this reason we reserve the right to impose rate limits and/or to block clients that are disrupting the public service.

            <p><em>"Etiquette" section based on the <a href="https://github.com/CrossRef/rest-api-doc#etiquette" target="_blank">Crossref API documentation</a>, available via <a href="https://creativecommons.org/licenses/by/4.0/" target="_blank">Creative Commons license</a>.


        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <h2 style="padding-top: 20px;">Table of contents</h2>
          <ul>
            % for chapter in docs.chapters:
              % for endpoint in chapter.endpoints:
                <li>{{ chapter.title }}: <a href="#{{ chapter.title.replace(" ", "-") }}-{{ endpoint.title.replace(" ", "-") }}">{{ endpoint.title }}</a> <code>{{ docs.base_url }}{{ endpoint.url }}</code>
              % end
            % end
          </ul>
        </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          % for chapter in docs.chapters:
            <h2 style="padding-top: 20px;">{{ chapter.title }}</h2>
            <div class="col-sm-10 offset-sm-1">
              % for endpoint in chapter.endpoints:
                <h3 id="{{ chapter.title.replace(" ", "-") }}-{{ endpoint.title.replace(" ", "-") }}">Endpoint: {{ endpoint.title }}</h3>
                <p>
                % if endpoint.description != "":
                  {{ endpoint.description }}<br>
                % end
                <code>{{ docs.base_url }}{{ endpoint.url }}</code></p>

                % if len(endpoint.path_arguments) + len(endpoint.get_arguments) > 0:
                  <h4>Arguments</h4>
                  <ul>
                    % for arg in endpoint.path_arguments + endpoint.get_arguments:
                      <li><code>{{ arg.name }}</code> &ndash; {{ arg.description }} {{ f"Default: {arg.default} " if arg.default is not None else "" }}{{ "<em>Required.</em>" if arg.required else "" }}
                      % if len(arg.acceptable) > 0:
                        <ul><li>Acceptable values:
                          % for i, val in enumerate(arg.acceptable):
                            <code>{{ val }}</code>{{ ", " if i < len(arg.acceptable) - 1 else "" }}
                          % end
                        </li></ul>
                      % end
                    % end
                  </ul>
                %end
                <h4>Example</h4>
                % for i, example in enumerate(endpoint.examples):
                  <h5>{{ example.title }}</h5>
                  <p>
                  % if example.description != "":
                    {{ example.description }}<br>
                  % end
                  <a href="{{ docs.base_url }}{{ example.url }}" target="_blank"><code>{{ docs.base_url }}{{ example.url }}</code></a></p>
                  <div class="accordion" id="accordion{{ accordion_count }}">
                    <div class="card">
                      <div class="card-header context" id="heading{{ accordion_count }}"  data-toggle="collapse" data-target="#collapse{{ accordion_count }}" aria-expanded="true" aria-controls="collapse{{ accordion_count }}">
                        <h6>Response (click to expand)</h6>
                      </div>
                      <div id="collapse{{ accordion_count }}" class="collapse" aria-labelledby="heading{{ accordion_count }}" data-parent="#accordion{{ accordion_count }}">
                        <div class="card-body">
                          <pre>{{ example.response }}</pre>
                        </div>
                      </div>
                    </div>
                  </div>
                  % accordion_count += 1
                %end
                <hr>
              % end
            </div>
          % end
        </div>
      </div>
    </div>

    %include("components/footer")

  </body>
</html>