<!DOCTYPE html>

<html>
  <head>
    <title>Login</title>
    <style type="text/css">
      .label {text-align: right}
      .error {color: red}
    </style>
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web:300' rel='stylesheet' type='text/css'>
	<style type="text/css">.titi{
		font-family: 'Titillium Web', sans-serif;
	}</style>
	<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">


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
    <h2>Login</h2>
    <form form="post" class="form-horizontal" role="form">
      <div class="form-group">
        <label class="control-label col-sm-2">username:</label>
        <div class="col-sm-10">
          <input type="text" name="username" class="form-control" placeholder="Enter username" value="{{username}}">
        </div>
      </div>
      <div class="form-group">
        <label class="control-label col-sm-2" >Password:</label>
        <div class="col-sm-10">          
          <input type="password" class="form-control" name="password" placeholder="Enter password" value="">
        </div>
      </div>

      <div class="form-group">        
        <div class="col-sm-offset-2 col-sm-10">
          <div class="checkbox">
            <label><input type="checkbox"> Remember me</label>
          </div>
        </div>
      </div>
      <div class="form-group">        
        <div class="col-sm-offset-2 col-sm-10">
          <button type="submit" class="btn btn-default">Submit</button>
        </div>
      </div>
    </form>
  </div>



    
  </body>

</html>
