
<!DOCTYPE html>
<html lang="en">
  <head>


    <meta charset="utf-8">
    <title>Know Place</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Know Place helps you control all your devices from one place.">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
    </style>
    <link href="bootstrap/css/bootstrap-responsive.css" rel="stylesheet">

  </head>

  <body>

    <div id="fb-root"></div>
    <script>
      var isConnected = false;
        // Additional JS functions here
        window.fbAsyncInit = function() {
          FB.init({
            appId      : '459658667442635', // App ID
            //channelUrl : '//WWW.YOUR_DOMAIN.COM/channel.html', // Channel File
            status     : true, // check login status
            cookie     : true, // enable cookies to allow the server to access the session
            xfbml      : true  // parse XFBML
          });

          // Additional init code here
          FB.getLoginStatus(function(response) {
            if (response.status === 'connected') {
              isConnected = true;
              testAPI();
            } else {
              login();
            }
            });
          };

        // Load the SDK Asynchronously
        (function(d){
           var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
           if (d.getElementById(id)) {return;}
           js = d.createElement('script'); js.id = id; js.async = true;
           js.src = "//connect.facebook.net/en_US/all.js";
           ref.parentNode.insertBefore(js, ref);
         }(document));

        function testAPI() {
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me', function(response) {
                window.alert('Good to see you, ' + response.name + '.');
            });
        }

        function login() {
          FB.login(function(response) {
              if (response.authResponse) {
                  // connected
                  testAPI();
              } else {
                  // cancelled
                  window.alert("not logged in");
              }
        });
}
    </script>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="index.php">Know Place</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="index.php">Home</a></li>
              <li><a href="data.php">My Data</a></li>
              <li><a href="#contact">Contact</a></li>
            </ul>
            <form class="navbar-form pull-right" method="post" action="#">
              <button type="submit" class="btn">Sign in</button>
            </form>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">

      <!-- Main hero unit for a primary marketing message or call to action -->
      <div class="hero-unit">
        <h1>Welcome!</h1>
        <p>
          A short description about the website and how to control specific devices will be located here.
        </p>

        <p><a href="#" class="btn btn-primary btn-large" data-toggle="collapse" data-target="#info">Learn more &raquo;</a></p>
        <div id="info" class="collapse out">
          <p>   
            More information about the project will go here along with how to customize personal devices.
          </p>
          <p>   
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tristique vestibulum leo, vel convallis risus ornare et. Integer ac nibh id tortor facilisis cursus. Mauris eleifend egestas sollicitudin. Curabitur varius orci non dolor facilisis egestas. Maecenas vitae justo et sem vulputate laoreet nec ut quam. Sed vitae massa ultrices felis euismod vehicula ac nec tortor. Sed leo felis, blandit sit amet ornare at, euismod quis mi.
          </p>
        </div>
 

      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span4">
          <h2>lamp light</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>

          <form method="post" action="check.php">
            <input type="radio" name="test1" value="on"> On<br>
            <input type="radio" name="test1" value="off"> Off<br><br>
            <button type="submit" inline class="btn">submit</button>
          </form>

        </div>
        <div class="span4">
          <h2>Device 2</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <!--<p><a class="btn" href="#">View details &raquo;</a></p>-->
       </div>
        <div class="span4">
          <h2>Device 3</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; Know Place - 2013</p>
      </footer>

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="bootstrap/js/jquery.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

  </body>
</html>
