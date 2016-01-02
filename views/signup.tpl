<!DOCTYPE html>

<html>
  <head>
    <title>Sign Up</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style type="text/css">
      .label {text-align: right}
      .error {color: red}
    </style>
    <link href='https://fonts.googleapis.com/css?family=Titillium+Web:300' rel='stylesheet' type='text/css'>
    <style type="text/css">.titi{
      font-family: 'Titillium Web', sans-serif;
    }</style>
    <link rel="stylesheet" type="text/css" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<body>

  </head>
    <body class="titi">
    <nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="197">
        <ul class="nav navbar-nav">
          <li><a href="/">Blog Home</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/signup"> Sign Up</a></li>
            <li><a href="/login"> Login</a></li>
         </ul>
    </nav>
    <div class="container">
      <h2>Signup</h2>
      <form method="post" class="form-horizontal" role="form">
        <div class="form-group">
          <label class="control-label col-sm-2">Username:</label>
          <div class="col-sm-10">
            <input type="text" name="username" class="form-control" id="email" placeholder="Enter username" value="{{username}}"><div class="error" >
             {{username_error}}            
            </div>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-2" >Password:</label>
          <div class="col-sm-10">          
            <input type="password" name="password" class="form-control" id="pwd" placeholder="Enter password" value=""><div class="error" >
             {{password_error}}            
            </div>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-2" >Verify Password:</label>
          <div class="col-sm-10">          
            <input type="password" name="verify" class="form-control" id="pwd" placeholder="verify password" value=""><div class="error" >
             {{verify_error}}            
            </div>
          </div>
        </div>
        <div class="form-group">
          <label class="control-label col-sm-2">Email(optional):</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="email" placeholder="Enter email" name="email" value="{{email}}"><div class="error" >
             {{email_error}}           
            </div>
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
      <h3>Already a user? <a href="/login">Login</a><p></h3>
    </div>   
  </body>
</html>
