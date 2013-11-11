
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

  <!-- <body onload="getCurrentStatus()"> -->
  <body>

    <d iv id="fb-root"></div>


    <style>
    #slider{
      width: 65%;
      margin-left: 15px;
      margin-bottom: 10px;
    }
    </style>

    <script>

      // code for jquery slider
    $(function() {
    $( "#slider" ).slider({
      value:0,
      min: 0,
      max: 255,
      step: 1,
      slide: function( event, ui ) {
        $( "#amount" ).val(ui.value );
      }
    });
    $( "#amount" ).val($( "#slider" ).slider( "value" ) );
    });

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
        function userLogin() {
          user_id = document.getElementById("user_id").value;

          $.ajax({
            getCurrentStatus(user_id);
          });
        }

        function getCurrentStatus(user_id) {
          $.ajax({
            type: "get",
            url: "/mydata",
            data: { "action": "getUserData", "user_id": user_id },
            success: function (response) {
              var hubs = response["hubs"];
              for(var i=0;i < hubs.length;i++) {
                var currHub = hubs[i];
                var currHubID = currHub["hub_id"];
                
                var nodes = currHub["nodes"];

                for (var j=0;j < nodes.length;j++) {
                  
                  var currNode = nodes[j];
                  var currNodeID = currNode["node_id"];
                  var currNodeName = currNode["name"];

                  var pins = nodes["pins"];

                  for(var k=0;k < pins.length;k++) {
                    var currPin = pins[k];
                    
                    //should be changed to current pin value
                    var currNodeValue = currNode["current_value"]; 
                    var currPinType = currPin["type"];
                    addToList(currNodeName, currNodeID, currNodeValue, currPinType);
                  }
                }
              }
            }
          });
        }

        function addNode() {
          user_id = document.getElementById("user_id").value;
          hub_id = document.getElementById("hub_id").value;
          name = document.getElementById("new_name").value;
          address_high = document.getElementById("new_address_high").value;
          address_low = document.getElementById("new_address_low").value;
          current_value = document.getElementById("new_current_value").value;
          type = document.getElementById("new_type").value;

          $.ajax({
            type: "post",
            url: "/addnode",
            data: { "action": "addNode", "user_id": user_id, "hub_id": hub_id, "name": name, "address_high": address_high, "address_low": address_low, "current_value": current_value, "type": type },
            success: function (response) {
              var status = response["status"];
              console.log(response);
              if (status === "SUCCESS") {
                //CALL JAVA TO PRINT HTML FOR NEW NODE
                addToList(name, response["node_id"], current_value);

              } else if (status === "FAILED") {
                //DID NOT ADD
                alert("AHHHH it Failed");
              }
            }
          });

        }

        function addToList(node_name, pin_id, currValue, currPinType) {


          var iDiv = document.createElement('div');
          iDiv.setAttribute("class","large-event");
          iDiv.id = "space-font";
          var aElement = document.createElement('a');
          aElement.setAttribute('data-toggle','collapse');
          aElement.setAttribute('data-target','#'+node_id);
          aElement.setAttribute('href','#');
          aElement.innerHTML = node_name;
          iDiv.appendChild(aElement);

          var typeDiv = document.createElement('div');
          typeDiv.id = pin_id;
          typeDiv.setAttribute('class','collapse out');
          iDiv.appendChild(typeDiv);

          var formDiv = document.createElement('div');
          formDiv.setAttribute('class','shift-right');
          typeDiv.appendChild(formDiv);

          if(currPinType === "sensor_M"){
            var sensorText = document.createTextNode(currValue);
            formDiv.appendChild(sensorText);
          }
          else{
            var formElement = document.createElement('form');
            formElement.setAttribute('method','post');
            formElement.setAttribute('style','display:inline');
            formElement.setAttribute('action','/testlamp'); //check, is this right?
            formDiv.appendChild(formElement);

            
            var inputElementA = document.createElement('input');
            inputElement1.setAttribute('type','hidden');
            inputElement1.setAttribute('name','type');
            inputElement1.setAttribute('value',currPinType);
            formElement.appendChild(inputElementA);

            if(currPinType === "output_R"){
              var inputElementText = document.createElement('input');
              inputElementText.setAttribute('type','text');
              inputElementText.setAttribute('id',pin_id+'Text');
              inputElementText.setAttribute('name','data_value');
              inputElementText.setAttribute('value',currValue);
              formElement.appendChild(inputElementText);
            }
            else{
              var inputElementOn = document.createElement('input');
              inputElementOn.setAttribute('type','radio');
              inputElementOn.setAttribute('id',pin_id+'On');
              inputElementOn.setAttribute('name','data_value');
              inputElementOn.setAttribute('value','on');
              formElement.appendChild(inputElementOn);

              var onText = document.createTextNode(' On ');
              formElement.appendChild(onText);

              var inputElement3 = document.createElement('input');
              inputElementOff.setAttribute('type','radio');
              inputElementOff.setAttribute('id',pin_id+'Off');
              inputElementOff.setAttribute('name','data_value');
              inputElementOff.setAttribute('value','off');
              inputElementOff.setAttribute('checked','');
              formElement.appendChild(inputElementOff);

              var offText = document.createTextNode(' Off ');
              formElement.appendChild(offText);

              
            }

            var inputElement4 = document.createElement('input');
            inputElement4.setAttribute('type','button');
            inputElement4.setAttribute('id',pin_id+'---'+'button');
            inputElement4.setAttribute('class','btn');
            inputElement4.setAttribute('inline','');
            inputElement4.setAttribute('value','Submit');
            inputElement4.setAttribute('onclick','nodeStatusChange(this.id)');
            formElement.appendChild(inputElement4);

          }
          (document.getElementById('thingsMainbox')).appendChild(iDiv);
          if(currPinType === "output_B"){
            if(currValue == "1") {
                  (document.getElementById(node_id+"On")).checked = true;
            } else {
              (document.getElementById(node_id+"Off")).checked = true;
            }
          }
        }

        function nodeStatusChange(buttonName) { //why not just use the id
          var id = (buttonName.split('---'))[0];
          var status = 0;

          if((document.getElementById(id+"Text") != null)){
            status = document.getElementById(id+"Text").value;
          }
          else if ((document.getElementById(id+"On")).checked == true) {
            status = 1;
          } else {
            status = 0;
          }
          $.ajax({
            type: "post",
            url: "/mydata",
            data: { "action" : "changeStatus", "user_id" : "0", "pin_id" : id, "new_current_value" : status },
            success: function (response) {
              var status = response["status"];
              alert(status);
              console.log(status);
              if (status === "SUCCESS") {
                //Change status was a success
              } else if (status === "FAILED") {
                //Change status was a failure
                alert("Unable to Change status of Node ID " + id + ".");
              }
            }
          });

        }


        /*

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
            data: { "action" : "changeStatus", "name" : lamp, "newStatus" : lampStatus },
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

        */


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
              <button type="button" class="btn" data-toggle="modal" data-target="#loginModal">Sign in</button>
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
          <form method="post" action="/addnode" >
              Name: <input type="text" id="new_name" name="new_name"><br>
              Address High: <input type="text" id="new_address_high" name="new_address_high"><br>
              Address Low: <input type="text" id="new_address_low" name="new_address_low"><br>
              Current Value: <input type="text" id="new_current_value" name="new_current_value"><br>
              Type: <input type="text" id="new_type" name="new_type"><br>
              <br>

              Hub: <!-- Temporary, needs a query -->
                <select id = "hub_id" name="hub_id" selectedvalue="0">
                  <option value="0">Hub 0</option>
                  <option value="1">Hub 1</option>
                  <option value="2">Hub 2</option>
                  <option value="3">Hub 3</option>
                </select>

                <!-- Temporary, need to learn cookies -->
                <input type="hidden" id="user_id" name="user_id" value="0">

                </hidden>
              <input type="button" inline class="btn" data-dismiss="modal" aria-hidden="true" onclick="addNode()" value="Submit">
            </form>
          <br><br><br>

        </div>

      </div>

            <!-- loginModal -->
      <div id="loginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 id="myModalLabel">User Login</h3>
        </div>
        <div class="modal-body">

          <br>
          <form method="post" action="/userlogin">
              User ID: <input type="text" id="user_id" name="user_id"><br>
              <input type="button" inline class="btn" data-dismiss="modal" aria-hidden="true" onclick="userLogin()" value="Submit">
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
<!--
          <div class="large-event" id="space-font">
            <a data-toggle="collapse" data-target="#5" href="#" class="">helloWorld</a>
            <div id="5" class="out in collapse" style="height: auto;">
              <div class="shift-right">
                <form method="post" style="display:inline" action="/mydata">
                <input type="hidden" name="node_address" value="1">
                <input type="button" id="5---button" class="btn" inline="" value="Submit" onclick="nodeStatusChange(this.id)">
              </form>
            </div>
          </div>
-->

          <iframe style="display:none;" name="hiddenframe"></iframe>

          <div class="large-event" id="space-font">

              <!-- Collapsable Button -->
              <!--
              <a data-toggle="collapse" data-target="#fan1" href="#" class="collapsed">
                Computer Fan
              </a>
              -->
              <!-- Fan Collapse Material -->
              <!--
              <div id="fan1" class="out collapse" style="height: 0px;"><br>
                <form method="post" style="display:inline" action="/mydata" target="hiddenframe">
                  <input type="hidden" name="action" value="changeStatus">
                  <input type="hidden" name="node_id" value="0">
                  <input type="text" name="new_current_value" id="amount" style="float: right; margin-right: 50px; width: 25px; border: 0; color: #f6931f; font-weight: bold;"/>
                  <div id="slider"></div><br>

                  <input inline style="float:right; margin-right: 18px" type="submit" class="btn" value="Submit">


                </form>
              </div>
              -->
          </div>
      </div>





        </div>
      </div>
    </div>








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
