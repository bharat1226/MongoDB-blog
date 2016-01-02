<!doctype HTML>
<html>
<head>
<title>Create a new post</title>
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:300' rel='stylesheet' type='text/css'>
	<style type="text/css">.titi{
		font-family: 'Titillium Web', sans-serif;
	}</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<body>
</head>
<body class="titi">
	<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
		%if (username != None):
		<div class="navbar-header">
	      <a class="navbar-brand" href="/welcome">Welcome {{username}}</a>
	    </div>
  		<ul class="nav navbar-nav">
		    <li ><a href="/">Blog Home</a></li>
		    <li ><a href="/welcome">User Home</a></li>
		    <li ><a href="/newpost">New Post</a></li>
  		</ul>
  		<ul class="nav navbar-nav navbar-right">
  			<li ><a href="/logout">Logout</a></li>
	     </ul>
	     %else:
	     <ul class="nav navbar-nav">
		    <li class="active"><a href="/">Blog Home</a></li>

  		</ul>
  		<ul class="nav navbar-nav navbar-right">
  			<li><a href="/signup"> Sign Up</a></li>
	        <li><a href="/login"> Login</a></li>
	     </ul>
	     %end
	</nav>

	<div class="container">
		<div class="row">
			<h2 class="text-center">Create a new post</h2>
			 <form role="form" action="/newpost" method="POST">
			 	<p style="color:red">{{errors}}</p>
			  <div class="form-group">
			    <label>Title:</label>
			    <input type="text" name="subject" class="form-control" value="{{subject}}">
			  </div>
			  <div class="form-group">
			    <label for="comment">Blog Entry:</label>
			    <textarea name="body" class="form-control" rows="5" id="comment">{{body}}</textarea>
			  </div>
			  <div class="form-group">
			    <label for="comment">Tags (please insert comma between tags):</label>
			    <textarea type="text" name="tags" class="form-control" valus="{{tags}}">{{body}}</textarea>
			  </div>
			  <button type="submit" value="Submit" class="btn btn-default">Submit</button>
			</form>
		</div>
	</div>
</body>
</html>

