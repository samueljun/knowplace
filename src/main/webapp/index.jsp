
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
    <script src="bootstrap/js/jquery.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>

  </head>

  <body>

    <div id="fb-root"></div>
    <script>
      var isConnected = false;
      var app_id;
      if (location.hostname === 'localhost') {
        app_id = '459658667442635';
      } else {
        app_id = '130174813840003';
      }
        // Additional JS functions here
        window.fbAsyncInit = function() {
          FB.init({
            appId      : app_id, // App ID
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

        imgs=Array("onBulb.jpg","offBulb.jpg");
        function lampStatusChange() {
          setTimeout(function() {
            if(document.getElementById("lampOn").checked==true) {
              document.getElementById("bulbPic").src=imgs[0];
            }
            else {
              document.getElementById("bulbPic").src=imgs[1];
            }
          },4000);
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
              <li><a href="#data">My Data</a></li>
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
        <h2>KnowPlace</h2>
        <p>
          It's like home automation!
        </p>

        <p><a href="#" class="btn btn-primary btn-large" data-toggle="collapse" data-target="#info">Learn more &raquo;</a></p>
        <div id="info" class="collapse out">
          <p>   
            Control you home devices without actually being there. <br>
            Created by: <br>
            Ryan Mercer <br>
            Samuel Jun <br>
            Roger Lam <br>
            Ray Tong <br>
            Samir Mody <br>
            Se Hun Choi <br>
            Yoshinori Osone
          </p>
        </div>
 

      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span6">
          <h2>lamp light</h2>
          <div class="row">
            <div class="span2">
            <img src="onBulb.jpg" id="bulbPic" width="100" height="160" alt="">
            </div>
            <div class="span3">
              <br><br>
            <form method="post" action="check.php">
              <input type="radio" id="lampOn" name="test1" value="on" checked> On<br>
              <input type="radio" id="lampOff" name="test1" value="off"> Off<br><br>
              <button type="button" inline class="btn" onclick="lampStatusChange()">submit</button>
            </form>
            </div>
          </div>
        </div>
        <div class="span6">
          <h2>Brightness Level</h2>
          <p>Adjust the brightness of your lamp!</p>
          <!--<p><a class="btn" href="#">View details &raquo;</a></p>-->
       </div>
      </div>

      <hr>
      <br><br><br><br><br>
      <footer>
        <p>&copy; Know Place - 2013</p>
      </footer>

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->


  </body>
</html>
