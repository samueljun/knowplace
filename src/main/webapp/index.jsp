
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Know Place test</title>
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
    <!-- <body> -->

    <div id="fb-root"></div>


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

        function getCurrentStatus() {
          user_id = document.getElementById("user_id").value;

          // user_id = "0";
          $.ajax({
            type: "get",
            url: "/mydata",
            data: { "action": "getUserData", "user_id": user_id },
            success: function (response) {
              // alert("in getCurrentStatus");
              var hubs = response["hubs"];

              for(var i=0; i < hubs.length;i++){
                var currHub = hubs[i];
                var nodes = currHub["nodes"];

                for (var j=0;j < nodes.length;j++) {
                  var currNode = nodes[j];
                  // var currValue = currNode["current_value"];//Temporary

                  var pins = currNode["pins"];
                  for(var k=0;k < pins.length;k++){
                     
                     var currPin = pins[k];
                     var currName = currPin["name"];
                     var currID = currPin["pin_id"];
                     var currType = currPin["type"];
                     var currValue = currPin["current_value"];//Temporary
                    addToList(currName,currID, currValue, currType);

                  }
                }
              }
              // addToList("what!","0","1","control_B");
            }
          });
        }

        function addNode() {
          name = document.getElementById("new_name").value;
          address_high = document.getElementById("new_address_high").value;
          address_low = document.getElementById("new_address_low").value;
          // current_value = document.getElementById("new_current_value").value;
          type = document.getElementById("new_type").value;

          $.ajax({
            type: "post",
            url: "/addnode",
            data: { "action": "addNode", "name": name, "address_high": address_high, "address_low": address_low, "current_value": current_value, "type": type },
            success: function (response) {
              var status = response["status"];
              console.log(response);
              if (status === "SUCCESS") {
                //CALL JAVA TO PRINT HTML FOR NEW NODE
                addToList(name, response["pin_id"], current_value, type);

              } else if (status === "FAILED") {
                //DID NOT ADD
                alert("AHHHH it Failed");
              }
            }
          });

        }

        function addToList(name, pin_id, currValue, currType) {


          var iDiv = document.createElement('div');
          iDiv.setAttribute("class","large-event");
          iDiv.id = "space-font";
          var aElement = document.createElement('a');
          aElement.setAttribute('data-toggle','collapse');
          aElement.setAttribute('data-target','#'+pin_id);
          aElement.setAttribute('href','#');
          aElement.innerHTML = name;
          iDiv.appendChild(aElement);

          var typeDiv = document.createElement('div');
          typeDiv.id = pin_id;
          typeDiv.setAttribute('class','collapse out');
          iDiv.appendChild(typeDiv);

          var formDiv = document.createElement('div');
          formDiv.setAttribute('class','shift-right');
          typeDiv.appendChild(formDiv);
          if(currType === "sensor_M")
          {
            var sensorText = document.createTextNode(currValue);
            formDiv.appendChild(sensorText);
          }
          else{
            var formElement = document.createElement('form');
            formElement.setAttribute('method','post');
            formElement.setAttribute('style','display:inline');
            formElement.setAttribute('action','/testlamp');
            formDiv.appendChild(formElement);

            var inputElementType = document.createElement('input');
            inputElementType.setAttribute('id', pin_id+'Type')
            inputElementType.setAttribute('type','hidden');
            inputElementType.setAttribute('name','type');
            inputElementType.setAttribute('value',currType);
            formElement.appendChild(inputElementType);
            // var inputElementUser = document.createElement('input');
            // inputLement
            if(currType === "control_R"){

              
              // var htmlBreak = document.createElement('br');
              // formElement.appendChild(htmlBeak);

              var inputElementText = document.createElement('input');
              inputElementText.setAttribute('type','text');
              inputElementText.setAttribute('id',pin_id+'Text');
              inputElementText.setAttribute('name','data_value');
              inputElementText.setAttribute('value',currValue);
              inputElementText.setAttribute('size','15');
              inputElementText.setAttribute('maxlength','50');//todo, change to 160
              formElement.appendChild(inputElementText);

              
              // formElement.appendChild(htmlBreak);
            }
            else{
              var inputElement2 = document.createElement('input');
              inputElement2.setAttribute('type','radio');
              inputElement2.setAttribute('id',pin_id+'On');
              inputElement2.setAttribute('name','data_value');
              inputElement2.setAttribute('value','on');
              formElement.appendChild(inputElement2);

              var onText = document.createTextNode(' On ');
              formElement.appendChild(onText);

              var inputElement3 = document.createElement('input');
              inputElement3.setAttribute('type','radio');
              inputElement3.setAttribute('id',pin_id+'Off');
              inputElement3.setAttribute('name','data_value');
              inputElement3.setAttribute('value','off');
              inputElement3.setAttribute('checked','');
              formElement.appendChild(inputElement3);

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

          if(currType === "control_B")
          {
            if(currValue === "1") {
              (document.getElementById(pin_id+"On")).checked = true;
            } else {
              (document.getElementById(pin_id+"Off")).checked = true;
            }
          }

        }

        function nodeStatusChange(buttonName) {
          var id = (buttonName.split('---'))[0];
          var status = 0;
          if((document.getElementById(id+"Type").value == "control_B")){
            if ((document.getElementById(id+"On")).checked == true) {
              status = 1;
            } else {
              status = 0;
            }
          }
          else{
            status = document.getElementById(id+"Text").value;
          }
          $.ajax({
            type: "post",
            url: "/mydata",
            data: { "action" : "changeStatus", "node_id" : id, "new_current_value" : status },
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
            <!-- I don't know why the form and button doesn't trigger the modal-->
            <!-- <form class="navbar-form pull-right" action="#"> -->
              <!-- <button type="button" class="btn"> -->
                <a href="#signInModal" role="button" data-toggle="modal">
                  Sign in
                </a>
              <!-- </button> -->
            <!-- </form> -->
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
      <div id="signInModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h3 id="myModalLabel">User Sign-In</h3>
        </div>
        <div class="modal-body">

          <br>
          <form method="post" action="/addNode">
              User ID <input type="text" id="user_id" name="user_id"><br>
              <input type="button" inline class="btn" data-dismiss="modal" aria-hidden="true" onclick="getCurrentStatus()" value="Submit">
            </form>
          <br><br><br>

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
          <form method="post" action="/addnode">
              Name: <input type="text" id="new_name" name="new_name"><br>
              Address High: <input type="text" id="new_address_high" name="new_address_high"><br>
              Address Low: <input type="text" id="new_address_low" name="new_address_low"><br>
              Current Value: <input type="text" id="new_current_value" name="new_current_value"><br>
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
              <a data-toggle="collapse" data-target="#fan1" href="#" class="collapsed">
                Computer Fan
              </a>

              <!-- Fan Collapse Material -->
              <div id="fan1" class="out collapse" style="height: 0px;"><br>
                  <form method="post" style="display:inline" action="/mydata" target="hiddenframe">
                    <input type="hidden" name="action" value="changeStatus">
                    <input type="hidden" name="node_id" value="0">
                    <input type="text" name="new_current_value" id="amount" style="float: right; margin-right: 50px; width: 25px; border: 0; color: #f6931f; font-weight: bold;"/>
                    <div id="slider"></div><br>

                    <input inline style="float:right; margin-right: 18px" type="submit" class="btn" value="Submit">


                  </form>
                </div>
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
