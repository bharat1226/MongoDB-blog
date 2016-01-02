<!DOCTYPE html>
<html lang="en">
<head>
<title>Travel Blog</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href='https://fonts.googleapis.com/css?family=Titillium+Web:300' rel='stylesheet' type='text/css'>
<style type="text/css">.titi{
	font-family: 'Titillium Web', sans-serif;
}</style>
<script type="text/javascript" src="scripts/bootstrap.js"></script>
<link rel="stylesheet" href="stylesheet/custom.css">
<link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<body>
	<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
		%if (username != None):
		<div class="navbar-header">
	      <a class="navbar-brand" href="/welcome">Welcome {{username}}</a>
	    </div>
  		<ul class="nav navbar-nav">
		    <li class="active"><a href="/">Blog Home</a></li>
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
	<h1 class="titi text-center">Travel Experience Blog</h1>

	%for post in myposts:
	<div class="container">
		<section class="row">
			<article class="col-md-2"></article>
			<article class="col-md-8">
				<h2><a href="/post/{{post['permalink']}}">{{post['title']}}</a></h2>
				Posted {{post['post_date']}} <i>By {{post['author']}}</i><br>
				Comments: 
				%if ('comments' in post):
				%numComments = len(post['comments'])
				%else:
				%numComments = 0
				%end
				<a href="/post/{{post['permalink']}}">{{numComments}}</a>
				<hr>
				{{!post['body']}}
				<p>
				<p>
				<em>Filed Under</em>: 
				%if ('tags' in post):
				%for tag in post['tags'][0:1]:
				<a href="/tag/{{tag}}">{{tag}}</a>
				%for tag in post['tags'][1:]:
				, <a href="/tag/{{tag}}">{{tag}}</a>
				%end
				%end
				</p>
			</article>
			<article class="col-md-2"></article>
		</section>
				%end
	</div>
</body>
</html>



