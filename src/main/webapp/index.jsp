
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
    <link href="bootstrap/css/slider.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>



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
    <script src="bootstrap/js/slider.js"></script>


  </head>

  <body>

    <div id="fb-root"></div>


    <style>
    #slider{
      width: 60%;
    }
    </style>

    <script>
     $(function() {
        $( "#slider" ).slider({
          value:0,
          min: 0,
          max: 100,
          step: 1,
        slide: function( event, ui ) {
          $( "#amount" ).val(ui.value );
         }
        });
        $( "#amount" ).val($( "#slider" ).slider( "value" ) );
      });

      var fbID;
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
              //connected
              isConnected = true;
              getID(response.authResponse);
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

        /*
        function testAPI() {
            console.log('Welcome!  Fetching your information.... ');
            FB.api('/me', function(response) {
                window.alert('Good to see you, ' + response.name + '.');
            });
        }
        */


        function getCurrentStatusonLogin() {
          $.ajax({
            type: "post",
            url: "/hello",
            data: JSON.stringify({
                "fb_id" : fbID
              }),
            success: function (response) {
              var status = response["status"];
              console.log(status);
              if (status === "READY") {
                //ENTRY READ
                if(response["lampStatus"] == "on") {
                  document.getElementById("lampOn").checked = true;
                  document.getElementById("bulbPic").src=imgs[0];
                } else {
                  document.getElementById("lampOff").checked = true;
                  document.getElementById("bulbPic").src=imgs[1];
                }
              } else if (status === "FAILED") {
                //NO ENTRY
              }
            }
          });
        }

        function getID(response) {
          fbID = response.userID;
        }

        function login() {
          FB.login(function(response) {
              if (response.authResponse) {
                  // connected
                  isConnected = true;
                  getID(response.authResponse);
              } else {
                  // cancelled
                  window.alert("You are not logged in.");
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
          <a class="brand" href="index.jsp">Know Place</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="index.jsp">Home</a></li>
              <li><a href="#data">My Data</a></li>
              <li><a href="/contact">Contact</a></li>
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
            <% System.out.println(fbID);%>
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
            <form method="post" action="/testlamp">
              <input type="hidden" name="node_address" value="1">
              <input type="radio" id="lampOn" name="data_value" value="on" checked> On<br>
              <input type="radio" id="lampOff" name="data_value" value="off"> Off<br><br>
              <input type="submit" inline class="btn" value="Submit">
            </form>
            </div>
          </div>
        </div>
        <div class="span6">
          <h2>Brightness Intensity</h2>
          <p>Adjust the brightness of your lamp!</p>
          <!--<p><a class="btn" href="#">View details &raquo;</a></p>-->


        <p>
          <input type="text" id="amount" style="border: 0; color: #f6931f; font-weight: bold;" />
        </p>

        <div id="slider"></div>



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
