
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
    <style>
    .large-event a{
      display: block;
    }
    </style>

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
          if(newVal == "1") {
            document.getElementById("lampOn1").checked = true;
            document.getElementById("bulbPic1").src=imgs[0];
          } else {
            document.getElementById("lampOff1").checked = true;
            document.getElementById("bulbPic1").src=imgs[1];
          }
        }

        function setLamp2(newVal) {
          if(newVal == "1") {
            document.getElementById("lampOn2").checked = true;
            document.getElementById("bulbPic2").src=imgs[0];
          } else {
            document.getElementById("lampOff2").checked = true;
            document.getElementById("bulbPic2").src=imgs[1];
          }
        }

        function getCurrentStatus() {
          $.ajax({
            type: "get",
            url: "/testlamp",
            data: { "action": "getStatus" },
            success: function (response) {
              var status = response["status"];
              console.log(response);
              if (status === "SUCCESS") {
                var lamp1 = response["lamp1"];
                var lamp2 = response["lamp2"];

                setLamp1(lamp1);
                setLamp2(lamp2);
                document.getElementById("bulbPic1").style.display = "inline";
                document.getElementById("bulbPic2").style.display = "inline";
              } else if (status === "FAILED") {
                //NO ENTRY
              }
            }
          });
        }

        function addNode() {

          address_low = document.getElementById("new_address_low").value;
          address_high = document.getElementById("new_address_high").value;
          name = document.getElementById("new_name").value;
          type = document.getElementById("new_type").value;


          $.ajax({
            type: "post",
            url: "/addnode",
            data: { "action": "addNode", "address_low": address_low, "address_high": address_high, "name": name, "type": type },
            success: function (response) {
              var status = response["status"];
              console.log(response);
              if (status === "SUCCESS") {
                //CALL JAVA TO PRINT HTML FOR NEW NODE
                addToList(name);

              } else if (status === "FAILED") {
                //DID NOT ADD
                alert("AHHHH it Failed");
              }
            }
          });

        }

        function addToList(name) {


          var iDiv = document.createElement('div');
          iDiv.setAttribute("class","large-event");
          iDiv.id = "space-font";
          var aElement = document.createElement('a');
          aElement.setAttribute('data-toggle','collapse');
          aElement.setAttribute('data-target','#'+name);
          aElement.setAttribute('href','#');
          aElement.innerHTML = name;
          iDiv.appendChild(aElement);

          var typeDiv = document.createElement('div');
          typeDiv.id = name;
          typeDiv.setAttribute('class','collapse out');
          iDiv.appendChild(typeDiv);

          var formDiv = document.createElement('div');
          formDiv.setAttribute('class','shift-right');
          typeDiv.appendChild(formDiv);

          var formElement = document.createElement('form');
          formElement.setAttribute('method','post');
          formElement.setAttribute('style','display:inline');
          formElement.setAttribute('action','/testlamp');
          formDiv.appendChild(formElement);

          var inputElement1 = document.createElement('input');
          inputElement1.setAttribute('type','hidden');
          inputElement1.setAttribute('name','node_address');
          inputElement1.setAttribute('value','1');

          var inputElement2 = document.createElement('input');
          inputElement2.setAttribute('type','radio');
          inputElement2.setAttribute('id',name+'On');
          inputElement2.setAttribute('name','data_value');
          inputElement2.setAttribute('value','on');

          var inputElement3 = document.createElement('input');
          inputElement3.setAttribute('type','radio');
          inputElement3.setAttribute('id',name+'Off');
          inputElement3.setAttribute('name','data_value');
          inputElement3.setAttribute('value','off');
          inputElement3.setAttribute('checked','');

          var inputElement4 = document.createElement('input');
          inputElement4.setAttribute('type','button');
          inputElement4.setAttribute('id',name+'Button');
          inputElement4.setAttribute('class','btn');
          inputElement4.setAttribute('inline','');
          inputElement4.setAttribute('value','Submit');
          inputElement4.setAttribute('onclick','nodeStatusChange(this.id)');

          var onText = document.createTextNode(' On ');
          var offText = document.createTextNode(' Off ');



          formElement.appendChild(inputElement1);
          formElement.appendChild(inputElement2);
          formElement.appendChild(onText);
          formElement.appendChild(inputElement3);
          formElement.appendChild(offText);
          formElement.appendChild(inputElement4);



          (document.getElementById('thingsMainbox')).appendChild(iDiv);



        }

        function nodeStatusChange() {

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
            lampStatus = "1";
          } else if (lamp == "lamp2" && document.getElementById("lampOn2").checked==true) {
            lampStatus = "1";
          } else {
            lampStatus = "0";
          }


          $.ajax({
            type: "post",
            url: "/testlamp",
            data: { "action" : lamp, "newStatus" : lampStatus },
            success: function (response) {
              var status = response["status"];
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
            <form class="navbar-form pull-right" action="#">
              <button type="button" class="btn">Sign in</button>
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
          <a class="btn btn-primary btn-medium" data-toggle="collapse" data-target="#info">Info &raquo;</a>

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

      <!-- Modal -->
      <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 id="myModalLabel">Add a New Node</h3>
        </div>
        <div class="modal-body">
          
          <br>
          <form method="post" action="/addnode_result">
              Address Low: <input type="text" id="new_address_low" name="new_address_low"><br>
              Address High: <input type="text" id="new_address_high" name="new_address_high"><br>
              Name: <input type="text" id="new_name" name="new_name"><br>
              Type: <input type="text" id="new_type" name="new_type"><br>
              <input type="button" inline class="btn" data-dismiss="modal" aria-hidden="true" onclick="addNode()" value="Submit">
            </form>
          <br><br><br>

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
              <a id="addEntry" href="#" role="button" data-toggle="modal">+ Place</a>
            </div>
            <div class="large-event" id="selectedEntry">
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
              <a id="addEntry" href="#" role="button" data-toggle="modal">+ Space</a>
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
            <div class="large-event" id="space-font-2">
              Study Room [House]
            </div>
          </div>
        </div>
        <div class="span4">
          <div id="thingsMainbox" class="mainbox">
            <div class="box-title">
              THINGS
            </div>
            <!-- Button to trigger modal -->

            <div class="add-sub-title" >
              <a id="addEntry" href="#myModal" role="button" data-toggle="modal">+ Thing</a>              
            </div>

            <div class="large-event" id="space-font">
              <!-- Collapsable Button -->
              <a data-toggle="collapse" data-target="#light1">
                Light 1
                <img src="onBulb.png" id="bulbPic1" width="25" height="40" alt="" style="display: none;">
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
              <a data-toggle="collapse" data-target="#light2">
                Light 2
                <img src="onBulb.png" id="bulbPic2" width="25" height="40" alt="" style="display: none;">
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
