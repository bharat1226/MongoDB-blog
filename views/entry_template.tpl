<!doctype HTML>
<html
<head>
<title>
Blog Post
</title>
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
	<div class="container">
		<div class="row">
			<h2>{{post['title']}}</h2>
				Posted {{post['date']}}<i> By {{post['author']}}</i><br>
			<hr>
				{{!post['body']}}
			<p>
			<em>Filed Under</em>: 
			%if ('tags' in post):
			%for tag in post['tags'][0:1]:
				<a href="/tag/{{tag}}">{{tag}}</a>
			%for tag in post['tags'][1:]:
			, <a href="/tag/{{tag}}">{{tag}}</a>
			%end
			%end
			%end
			</p>
				Comments: 
			<ul>
			%if ('comments' in post):
			%numComments = len(post['comments'])
			%else:
			%numComments = 0
			%end
			%for i in range(0, numComments):
			<form action="/like" method="POST">
				<input type="hidden" name="permalink", value="{{post['permalink']}}">
				<input type="hidden" name="comment_ordinal", value="{{i}}">
			Author: {{post['comments'][i]['author']}}<br>
			Likes: {{post['comments'][i]['num_likes']}} <input type="submit" value="Like"></form><br>
			{{post['comments'][i]['body']}}<br>
			<hr>
			%end
			<h3>Add a comment</h3>
			<form role="form" action="/newcomment" method="POST">
			  <div class="form-group">
			    <input type="hidden" name="permalink" class="form-control" value="{{post['permalink']}}">
			    <p style="color:red">{{errors}}</p>
			  </div>
			  <div class="form-group">
			    <label>Name(required):</label>
			    <input type="text" name="commentName" class="form-control" value="{{comment['name']}}">
			  </div>
			  <div class="form-group">
			    <label>Email(optional):</label>
			    <input type="text" name="commentEmail" class="form-control" value="{{comment['email']}}"></input>
			  </div>
			  <div class="form-group">
			    <label for="comment">Comment:</label>
			    <textarea name="commentBody" class="form-control" rows="5" id="comment">{{comment['body']}}</textarea>
			  </div>
			  <button type="submit" value="Submit" class="btn btn-default">Submit</button>
			</form>
			</ul>
		</div>
	</div>
</body>
</html>


