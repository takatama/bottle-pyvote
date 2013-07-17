<!DOCTYPE html>
<html>
  <head>
    <title>{{title or ''}}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <script src="//code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <style>
      body {
        padding-top: 60px;
      }
      @media (max-width: 980px) {
        body {
          padding-top: 0;
        }
      }
    </style>
  </head>
  <body>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="brand" href="/">PyVote</a>
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <div class="nav-collapse">
            <ul class="nav pull-right">
              <li><a href="/events/list">Events</a></li>
              <li><a href="/users/login">Login</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
    %include
    </div>
  </body>
</html>
