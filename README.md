### Travel Blog using Mongo-DB and Bottle-Framework(python)
In this web-application, MVC architecture is used. The model manages the data of the application. MongoDB is used in this application which is a non-relational database. It responds to the request from the view and it also responds to instructions from the controller to update itself. The data is displayed to the end-user via templating engine. Bottle-framework is used as server. This application is programmed in python programming language. The data is displayed to user in web browser and user can control the data and manipulate it. Controller is responsible for responding to user input and perform interactions on the data objects. The controller receives the input, it validates the input and then performs the business operation that modifies the state of the data model.
####Bottle Framework
Bottle framework is used to run the server. It is a web framework which is a simple framework for small projects. It gets the http requests from the user. Pymongo is a python library used for connecting mongo-process. It acts as glue to the mongo-process. The data is read and written in the database using Py-Mongo. To directly interact with mongo-process mongo shell is used which is javascript shell interpreter in command line interface. It has fast and pythonic built in template engine (and also supports JINJA2 template engine).  It has convenient access to form data, file uploads, cookies and headers. Bottle framework has built in http development server.
####To start server
	$python blog.py


The graphical user interface of the blog is very smooth and the website is responsive. Bootstrap framework is used for the styling of blog. Users can share travel experiences and can learn from other travel experiences.
