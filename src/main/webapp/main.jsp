
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
    
    <script src="bootstrap/js/jquery.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
    
    <script src="bootstrap/js/slider.js"></script>


  </head>

  <body onload="getCurrentStatus()">

    <div id="fb-root"></div>


    <style>
    #slider{
      width: 60%;
    }
    </style>

    <script>

      /*
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
        */

        imgs=Array("onBulb.png","offBulb.png");

        function setLamp1(newVal) {
          if(newVal == "ON") {
            document.getElementById("lampOn1").checked = true;
            document.getElementById("bulbPic1").src=imgs[0];
          } else {
            document.getElementById("lampOff1").checked = true;
            document.getElementById("bulbPic1").src=imgs[1];
          }
        }

        function setLamp2(newVal) {
          if(newVal == "ON") {
            document.getElementById("lampOn2").checked = true;
            document.getElementById("bulbPic2").src=imgs[0];
          } else {
            document.getElementById("lampOff2").checked = true;
            document.getElementById("bulbPic2").src=imgs[1];
          }
        }

        function getCurrentStatus() {
          $.ajax({
            type: "post",
            url: "/testlamp",
            data: JSON.stringify({
                "action" : "getStatus"
              }),
            success: function (response) {
              var status = response["status"]
              console.log(status);
              if (status === "SUCCESS") {
                var lamp1 = response["lamp1"];
                var lamp2 = response["lamp2"];

                setLamp1(lamp1);
                setLamp2(lamp2);
              } else if (status === "FAILED") {
                //NO ENTRY
              }
            }
          });
        }


        function lampStatusChange(val) {
          var lamp;
          var lampStatus;

          if(val == "lampButton1") {
            lamp = "lamp1";
          } else {
            lamp = "lamp2";
          }

          if(lamp == "lamp1" && document.getElementById("lampOn1").checked==true) {
            lampStatus = "ON";
          } else if (lamp == "lamp2" && document.getElementById("lampOn2").checked==true) {
            lampStatus = "ON";
          } else {
            lampStatus = "OFF";
          }
  

          $.ajax({
            type: "post",
            url: "/testlamp",
            data: JSON.stringify({
                "action" : lamp,
                "newStatus" : lampStatus
              }),
            success: function (response) {
              var status = response["status"]
              console.log(status);
              if (status === "SUCCESS") {
                if(lamp=="lamp1") {
                  setLamp1(response["lamp1"]);
                }
                else {
                  setLamp2(response["lamp2"]);
                }
              } else if (status === "FAILED") {
                //NO ENTRY
              }
            }
          });
        }



    </script>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            
          </button>
          <a class="brand" href="index.jsp">Know Place</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">
                <div class="white-over">
                  It's Like Home Automation</div></a></li>
            
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
        <h3>There's KnowPlace Like Home...</h3>
        
        <div class="spacer">
          <a href="#" class="btn btn-primary btn-medium" data-toggle="collapse" data-target="#info">Info &raquo;</a>
        
          <div id="info" class="collapse out">
            <p>
              Control your home devices without actually being there. <br><br>
              Created by:
              <p>
                Ryan Mercer, Samuel Jun, Roger Lam, Ray Tong, Samir Mody, Se Hun Choi, Yoshinori Osone
              </p>
            </p>
          </div>
        </div>




      </div>

      <!-- Example row of columns -->
      <div class="row">
        <div class="span4">
          <div class="mainbox">
            <div class="box-title">
              PLACES
            </div>
            <div class="add-sub-title">
              + Place
            </div>
            <div class="large-event">
              House
            </div>
            <div class="large-event">
              Office
            </div>
            <div class="large-event">
              Yacht
            </div>
          </div>
        </div>
        <div class="span4">
          <div class="mainbox">
            <div class="box-title">
              SPACES
            </div>
            <div class="add-sub-title">
              + Space
            </div>
            <div class="large-event" id="space-font">
              Master Bedroom [House]
            </div>
            <div class="large-event" id="space-font">
              Kid's Bedroom [House]
            </div>
            <div class="large-event" id="space-font">
              Guest Bedroom [House]
            </div>
            <div class="large-event" id="space-font">
              Study Room [House]
            </div>
          </div>
        </div>
        <div class="span4">
          <div class="mainbox">
            <div class="box-title">
              THINGS
            </div>
            <div class="add-sub-title">
              + Thing
            </div>
            <div class="large-event" id="space-font">
              Temperature
            </div>
            <div class="large-event" id="space-font">
              Fan Speed
            </div>

            
            <div class="large-event" id="space-font">
              <!-- Collapsable Button -->
              <a data-toggle="collapse" data-target="#light1" href="#">
                Light 1
                <img src="onBulb.png" id="bulbPic1" width="25" height="40" alt="">
              </a>

              <!-- LIGHT 1 Collapse Material -->
              <div id="light1" class="collapse out">
                <div class="shift-right">
                  <form method="post" style="display:inline" action="/testlamp">
                    <input type="hidden" name="node_address" value="1">
                    <input type="radio" id="lampOn1" name="data_value" value="on" checked> On
                    <input type="radio" id="lampOff1" name="data_value" value="off"> Off
                    <input type="button" id="lampButton1" inline class="btn" onclick="lampStatusChange(this.id)" value="Submit">
                  </form>
                </div>
              </div>
            </div>

            <div class="large-event" id="space-font">
              <!-- Collapsable Button -->
              <a data-toggle="collapse" data-target="#light2" href="#">
                Light 2 
                <img src="onBulb.png" id="bulbPic2" width="25" height="40" alt="">
              </a>
              
              <!-- LIGHT 2 Collapse Material -->
              <div id="light2" class="collapse out">
                <div class="shift-right">
                  <form method="post" style="display:inline" action="/testlamp">
                    <input type="hidden" name="node_address" value="2">
                    <input type="radio" id="lampOn2" name="data_value" value="on" checked> On
                    <input type="radio" id="lampOff2" name="data_value" value="off"> Off
                    <input type="button" id="lampbutton2" inline class="btn" onclick="lampStatusChange(this.id)" value="Submit">
                  </form>
                </div>
              </div>
            </div>

        </div>
      </div>
    </div>

<!--
        <p>
          <input type="text" id="amount" style="border: 0; color: #f6931f; font-weight: bold;" />
        </p>

        <div id="slider"></div>
-->


       
      <hr>
      <br><br><br>
      <footer>
        <p>&copy; Know Place - 2013</p>
      </footer>

      </div>

      

    </div> <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->


  </body>
</html>