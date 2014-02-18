<!DOCTYPE html>
<html lang="en">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta charset="utf-8">
		<title>Know Place</title>
		<meta name="description" content="Know Place helps you control all your devices from one place.">
		<meta name="author" content="">

		<!-- STYLESHEETS -->
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="stylesheet" href="css/slider.css">

		<!-- CUSTOM STYLESHEETS -->
		<link rel="stylesheet" href="css/knowplace.css">

		<!-- JAVASCRIPT -->
		<script src="js/jquery-2.1.0.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/slider.js"></script>

		<!-- CUSTOM JAVASCRIPT -->
		<script src="js/knowplace.js"></script>
	</head>

	<body>
		<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="index.jsp">Know Place</a>
				</div>
				<div class="navbar-collapse collapse">
					<p class="navbar-text">It's Like Home Automation</p>
					<form class="navbar-form navbar-right" role="form">
						<div class="form-group">
							<input type="text" placeholder="Email" class="form-control">
						</div>
						<div class="form-group">
							<input type="password" placeholder="Password" class="form-control">
						</div>
						<button type="submit" class="btn btn-success">Sign in</button>
					</form>
				</div><!--/.navbar-collapse -->
			</div>
		</div>

		<div class="jumbotron">
			<div class="container">
				<h2>There's KnowPlace Like Home...</h2>
				<div class="spacer">
					<a class="btn btn-primary btn-medium" data-toggle="collapse" data-target="#info">Info &raquo;</a>
					<div id="info" class="collapse out">
						<p>Control your home devices through the internet</p>
						<p>Created by: Ryan Mercer, Samuel Jun, Roger Lam, Ray Tong, Samir Mody, Se Hun Choi, Yoshinori Osone</p>
					</div>
				</div>
			</div>
		</div>

		<div class="container">
			<div class="row">
				<div class="col-md-4" id="places">
					<ul class="list-group">
						<a class="list-group-item list-group-item-info">PLACES<span class="badge">3</span></a>
						<a class="list-group-item" href="#addPlace" data-toggle="modal">+ Places</a>
						<a class="list-group-item active">House</a>
						<a class="list-group-item">Office</a>
						<a class="list-group-item">Yacht</a>
					</ul>
				</div>
				<div class="col-md-4" id="spaces">
					<ul class="list-group">
						<a class="list-group-item list-group-item-info">SPACES<span class="badge">5</span></a>
						<a class="list-group-item" href="#addSpace" data-toggle="modal">+ Places</a>
						<a class="list-group-item">Master Bedroom</a>
						<a class="list-group-item">Kid's Bedroom</a>
						<a class="list-group-item">Guest Bedroom</a>
						<a class="list-group-item">Study Room</a>
						<a class="list-group-item active">Laundry Room</a>
					</ul>
				</div>
				<div class="col-md-4" id="things">
					<ul class="list-group">
						<a class="list-group-item list-group-item-info">THINGS<span class="badge">3</span></a>
						<a class="list-group-item" href="#addThing" data-toggle="modal">+ Places</a>
					</ul>
				</div>
			</div>

			<hr>

			<footer>
				<p>&copy; Know Place - 2013</p>
			</footer>
		</div><!-- /container -->

		<!-- Modals -->
		<div id="addThing" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="Add Thing" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 id="myModalLabel">Add a New Thing</h4>
					</div>
					<form method="post" action="/addnode" class="form-horizontal" role="form">
						<div class="modal-body">
							<div class="form-group">
								<label for="new_name" class="col-sm-3 control-label">Name:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="new_name" name="new_name">
								</div>
							</div>
							<div class="form-group">
								<label for="new_address_high" class="col-sm-3 control-label">Address High:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="new_address_high" name="new_address_high">
								</div>
							</div>
							<div class="form-group">
								<label for="new_address_low" class="col-sm-3 control-label">Address Low:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="new_address_low" name="new_address_low">
								</div>
							</div>
							<div class="form-group">
								<label for="new_current_value" class="col-sm-3 control-label">Current Value:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="new_current_value" name="new_current_value">
								</div>
							</div>
							<div class="form-group">
								<label for="new_type" class="col-sm-3 control-label">Type:</label>
								<div class="col-sm-9">
									<input type="text" class="form-control" id="new_type" name="new_type">
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<input type="button" class="btn btn-primary" data-dismiss="modal" onclick="addNode()" value="Submit">
						</div>
					</form>
				</div>
			</div>
		</div>

	</body>
</html>
