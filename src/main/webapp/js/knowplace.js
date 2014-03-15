$(document).ready(function() {
	// code for jquery slider
	$("#slider").slider({
		value:0,
		min: 0,
		max: 255,
		step: 1,
		slide: function(event, ui) {
			$("#amount").val(ui.value);
		}
	});
	$("#amount").val($("#slider").slider("value"));

	$("form.changeStatus").submit(function(e) {
		e.preventDefault();
		var data = $(this).serialize();
		console.log(data);
	});
	getCurrentStatus();
});

function getCurrentStatus() {
	// user_id = document.getElementById("user_id").value;
	user_id = "0";
	$.ajax({
		type: "get",
		url: "/mydata",
		data: {
			"action": "getUserData",
			"user_id": user_id
		},
		success: function (response) {
			var hubs = response["hubs"];

			for (var i = 0; i < hubs.length; i++) {
				var currHub = hubs[i];
				var nodes = currHub["nodes"];

				for (var j = 0; j < nodes.length; j++) {
					var currNode = nodes[j];

					var pins = currNode["pins"];
					for (var k = 0; k < pins.length; k++) {
						var currPin = pins[k];
						var currName = currPin["name"];
						var currID = currPin["pin_id"];
						var currType = currPin["type"];
						var currValue = currPin["current_value"]; // Temporary
						addThingList(currName, currID, currValue, currType);
					}
				}
			}
		}
	});
}

function addNode() {
	name = document.getElementById("new_name").value;
	address_high = document.getElementById("new_address_high").value;
	address_low = document.getElementById("new_address_low").value;
	current_value = document.getElementById("new_current_value").value; //todo
	type = document.getElementById("new_type").value;

	$.ajax({
		type: "post",
		url: "/addnode",
		data: {
			"action": "addNode",
			"name": name,
			"address_high": address_high,
			"address_low": address_low,
			"current_value": current_value,
			"type": type
		},
		success: function (response) {
			var status = response["status"];
			console.log(response);
			if (status === "SUCCESS") {
				// CALL JAVA TO PRINT HTML FOR NEW NODE
				addToList(name, response["pin_id"], current_value, type);
			}
			else if (status === "FAILED") {
				// DID NOT ADD
				alert("Error");
			}
		}
	});
}

function isStaticType(type) {
	switch (type) {
		case "sensor_M":
		case "sensor_V":
		case "static_ID":
			return true;
			break;
		default:
			return false;
			break;
	}
}

function toggleCollapse(thing) {
	$(thing).collapse("toggle");
}

//========================
// HTML DOM Creation START
//========================
function createHiddenInput(name, value) {
	var input = document.createElement("input");
	input.setAttribute("type", "hidden");
	input.setAttribute("name", name);
	input.setAttribute("value", value);
	return input;
}

function createLabel(text) {
	var label = document.createElement("label");
	label.setAttribute("class", "col-sm-3 control-label");
	label.innerHTML = text;
	return label;
}

function createTextInput() {
	var input = document.createElement("input");
	input.setAttribute("class", "form-control");
	input.setAttribute("type", "text");
	input.setAttribute("name", "value");
	return input;
}

function createSubmitInput() {
	var input = document.createElement("input");
	input.setAttribute("class", "btn btn-default");
	input.setAttribute("type", "submit");
	input.setAttribute("value", "Submit");
	return input;
}

function createFormGroup(text) {
	var formGroup = document.createElement("div");
	formGroup.setAttribute("class", "form-group");
	formGroup.appendChild(createLabel(text));
	return formGroup;
}

function createBinaryFormGroup(pin_id, value) {
	var formGroup = createFormGroup("New:");

	var div = document.createElement("div");
	div.setAttribute("class", "col-sm-9");
	// ON
	var onLabel = document.createElement("label");
	onLabel.setAttribute("class", "radio-inline");

	var on = document.createElement("input");
	on.setAttribute("type", "radio");
	on.setAttribute("name", "value");
	on.setAttribute("value", value);
	if (value != 0)
		on.checked = true;

	onLabel.appendChild(on);
	onLabel.appendChild(document.createTextNode("On"));
	div.appendChild(onLabel);

	// OFF
	var offLabel = document.createElement("label");
	offLabel.setAttribute("class", "radio-inline");

	var off = document.createElement("input");
	off.setAttribute("type", "radio");
	off.setAttribute("name", "value");
	off.setAttribute("value", value);
	if (value == 0)
		off.checked = true;

	offLabel.appendChild(off);
	offLabel.appendChild(document.createTextNode("Off"));
	div.appendChild(offLabel);

	formGroup.appendChild(div);
	return formGroup;
}

function createCurrentFormGroup(value) {
	var formGroup = createFormGroup("Current:");

	var div = document.createElement("div");
	div.setAttribute("class", "col-sm-9");

	var p = document.createElement("p");
	p.setAttribute("class", "form-control-static");
	p.innerHTML = value;
	div.appendChild(p);

	formGroup.appendChild(div);
	return formGroup;
}

function createTextFormGroup() {
	var formGroup = createFormGroup("New:");

	var div = document.createElement("div");
	div.setAttribute("class", "col-sm-9");

	var input = createTextInput();
	div.appendChild(input);
	formGroup.appendChild(div);

	return formGroup;
}

function createSubmitFormGroup() {
	var formGroup = document.createElement("div");
	formGroup.setAttribute("class", "form-group");

	var div = document.createElement("div");
	div.setAttribute("class", "col-sm-offset-3 col-sm-9");

	var input = createSubmitInput();

	div.appendChild(input);
	formGroup.appendChild(div);

	return formGroup;
}

//======================
// HTML DOM Creation END
//======================

function addThingList(name, pin_id, value, type) {
	var thing = document.createElement("a");
	thing.setAttribute("class", "list-group-item");

	var heading = document.createElement("div");
	heading.innerHTML = name;
	heading.setAttribute("data-toggle", "collapse");
	heading.setAttribute("data-parent", "#things");
	heading.setAttribute("data-target", "#thing" + pin_id);
	heading.setAttribute("href", "#thing" + pin_id);
	heading.setAttribute("onclick", "toggleCollapse('thing" + pin_id + "')");
	thing.appendChild(heading);

	var body = document.createElement("div");
	body.setAttribute("class", "collapse");
	body.setAttribute("id", "thing" + pin_id);

	body.appendChild(document.createElement("hr"));

	if (isStaticType(type)) {
		var div = document.createElement("div");
		div.setAttribute("class", "form-horizontal");
		div.appendChild(createCurrentFormGroup(value));
		body.appendChild(div);
	}
	else {
		var form = document.createElement("form");
		form.setAttribute("class", "form-horizontal");
		form.setAttribute("role", "form");
		form.setAttribute("action", "mydata");
		form.setAttribute("method", "post");

		form.appendChild(createHiddenInput("action", "changeStatus"));
		form.appendChild(createHiddenInput("pin_id", pin_id));
		form.appendChild(createCurrentFormGroup(value));

		if (type === "control_B") {
			form.appendChild(createBinaryFormGroup(pin_id, value));
		}
		else if (type === "control_R") {
			form.appendChild(createTextFormGroup());
		}
		else {
			form.appendChild(createTextFormGroup());
		}

		form.appendChild(createSubmitFormGroup());
		body.appendChild(form);
	}

	thing.appendChild(body);
	$("#things").append(thing);
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
	if (currType === "sensor_M" || currType === "static_ID") {
		var sensorText = document.createTextNode(currValue);
		formDiv.appendChild(sensorText);
	}
	else {
		var formElement = document.createElement('form');
		formElement.setAttribute('method','post');
		formElement.setAttribute('style','display:inline');
		formElement.setAttribute('action','/mydata');
		formDiv.appendChild(formElement);

		var inputElementType = document.createElement('input');
		inputElementType.setAttribute('id', pin_id+'Type')
		inputElementType.setAttribute('type','hidden');
		inputElementType.setAttribute('name','type');
		inputElementType.setAttribute('value',currType);
		formElement.appendChild(inputElementType);
		// var inputElementUser = document.createElement('input');
		// inputLement

		if (currType === "control_R") {
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
		// else if (currTyep === "control_V") {
			 /* Fan Collapse Material*/
			// <div id="fan1" class="out collapse" style="height: 0px;"><br>
			//     <form method="post" style="display:inline" action="/mydata" target="hiddenframe">
			//       <input type="hidden" name="action" value="changeStatus">
			//       <input type="hidden" name="node_id" value="0">
			//       <input type="text" name="new_current_value" id="amount" style="float: right; margin-right: 50px; width: 25px; border: 0; color: #f6931f; font-weight: bold;"/>
			//       <div id="slider"></div><br>

			//       <input inline style="float:right; margin-right: 18px" type="submit" class="btn" value="Submit">


			//     </form>
			//   </div>

		//         var inputElementHiddenAction = document.createElement('input');
		//         inputElementHiddenAction.setAttribute('type', 'hidden');
		//         inputElementHiddenAction.setAttribute('name', 'action');
		//         inputElementHiddenAction.setAttribute('value', 'changeStatus');
		//         formElement.appendChild(inputElementHiddenAction);

		//         var inputElementHiddenNodeID = document.createElement('input');
		//         inputElementHiddenNodeID.setAttribute('type', 'hidden');
		//         inputElementHiddenNodeID.setAttribute('name', 'node_id');
		//         inputElementHiddenNodeID.setAttribute('value', '0');
		//         formElement.appendChild(inputElementHiddenNodeID);

		//         var inputElementText = document.createElement('input');
		//         inputElementText.setAttribute('type', 'text');
		//         inputElementText.setAttribute('name', 'new_current_value');
		//         inputElementText.setAttribute('id', 'amount');
		//         inputElementText.setAttribute('style', 'float: right; margin-right: 50px; width: 25px; border: 0; color: #f6931f; font-weight: bold;');
		//         formElement.appendChild(inputElementText);

		//         var inputElementDivSlider = document.createElement('div');
		//         inputElementDivSlicer.setAttribute('id', 'slider');
		//         formElement.appendChild(inputElementText);

		//         var formatElementBr = document.createElement('br');
		//         FormElement.appendChild(formatElement);
		// }
		else {
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

	$("#things ul").append(iDiv);

	if (currType === "control_B") {
		if (currValue === "1") {
			(document.getElementById(pin_id + "On")).checked = true;
		}
		else {
			(document.getElementById(pin_id + "Off")).checked = true;
		}
	}

}

function nodeStatusChange(buttonName) {
	var id = (buttonName.split('---'))[0];
	var status = 0;
	if ((document.getElementById(id + "Type").value == "control_B")) {
		if ((document.getElementById(id + "On")).checked == true) {
			status = 1;
		}
		else {
			status = 0;
		}
	}
	else {
		status = document.getElementById(id + "Text").value;
	}
	$.ajax({
		type: "post",
		url: "/mydata",
		data: {
			"action": "changeStatus",
			"node_id": id,
			"new_current_value": status
		},
		success: function (response) {
			var status = response["status"];
			alert(status);
			console.log(status);
			if (status === "SUCCESS") {
				//Change status was a success
			}
			else if (status === "FAILED") {
				//Change status was a failure
				alert("Unable to Change status of Node ID " + id + ".");
			}
		}
	});
}
