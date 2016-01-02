import pymongo
import blogPostDAO
import sessionDAO
import userDAO
import bottle
import cgi
import re

__author__ = 'golib'

@bottle.route('/')
def blog_index():
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie)
    l = posts.get_posts(10)
    return bottle.template('blog_template', dict(myposts=l, username=username))

@bottle.route('/tag/<tag>')
def posts_by_tag(tag="notfound"):
    cookie = bottle.request.get_cookie("session")
    tag = cgi.escape(tag)
    username = sessions.get_username(cookie)
    l = posts.get_posts_by_tag(tag, 10)
    return bottle.template('blog_template', dict(myposts=l, username=username))

@bottle.get("/post/<permalink>")
def show_post(permalink="notfound"):
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie)
    permalink = cgi.escape(permalink)
    print "about to query on permalink = ", permalink
    post = posts.get_post_by_permalink(permalink)
    if post is None:
        bottle.redirect("/post_not_found")
    comment = {'name': "", 'body': "", 'email': ""}
    return bottle.template("entry_template", dict(post=post, username=username, errors="", comment=comment))

@bottle.post('/newcomment')
def post_new_comment():
    name = bottle.request.forms.get("commentName")
    email = bottle.request.forms.get("commentEmail")
    body = bottle.request.forms.get("commentBody")
    permalink = bottle.request.forms.get("permalink")
    post = posts.get_post_by_permalink(permalink)
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie)
    if post is None:
        bottle.redirect("/post_not_found")
        return
    if name == "" or body == "":
        comment = {'name': name, 'email': email, 'body': body}
        errors = "Post must contain your name and an actual comment."
        return bottle.template("entry_template", dict(post=post, username=username, errors=errors, comment=comment))
    else:
        posts.add_comment(permalink, name, email, body)
        bottle.redirect("/post/" + permalink)

@bottle.post('/like')
def post_comment_like():
    permalink = bottle.request.forms.get("permalink")
    permalink = cgi.escape(permalink)
    comment_ordinal_str = bottle.request.forms.get("comment_ordinal")
    comment_ordinal = int(comment_ordinal_str)
    post = posts.get_post_by_permalink(permalink)
    if post is None:
        bottle.redirect("/post_not_found")
        return
    posts.increment_likes(permalink, comment_ordinal)
    bottle.redirect("/post/" + permalink)

@bottle.get("/post_not_found")
def post_not_found():
    return "Sorry, post not found"

@bottle.get('/newpost')
def get_newpost():
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie) 
    if username is None:
        bottle.redirect("/login")
    return bottle.template("newpost_template", dict(subject="", body = "", errors="", tags="", username=username))

@bottle.post('/newpost')
def post_newpost():
    title = bottle.request.forms.get("subject")
    post = bottle.request.forms.get("body")
    tags = bottle.request.forms.get("tags")
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie) 
    if username is None:
        bottle.redirect("/login")
    if title == "" or post == "":
        errors = "Post must contain a title and blog entry"
        return bottle.template("newpost_template", dict(subject=cgi.escape(title, quote=True), username=username,
                                                        body=cgi.escape(post, quote=True), tags=tags, errors=errors))
    tags = cgi.escape(tags)
    tags_array = extract_tags(tags)
    escaped_post = cgi.escape(post, quote=True)
    newline = re.compile('\r?\n')
    formatted_post = newline.sub("<p>", escaped_post)
    permalink = posts.insert_entry(title, formatted_post, tags_array, username)
    bottle.redirect("/post/" + permalink)

@bottle.get('/signup')
def present_signup():
    return bottle.template("signup",
                           dict(username="", password="",
                                password_error="",
                                email="", username_error="", email_error="",
                                verify_error =""))

@bottle.get('/login')
def present_login():
    return bottle.template("login",
                           dict(username="", password="",
                                login_error=""))

@bottle.post('/login')
def process_login():
    username = bottle.request.forms.get("username")
    password = bottle.request.forms.get("password")
    print "user submitted ", username, "pass ", password
    user_record = users.validate_login(username, password)
    if user_record:
        session_id = sessions.start_session(user_record['_id'])
        if session_id is None:
            bottle.redirect("/internal_error")
        cookie = session_id
        bottle.response.set_cookie("session", cookie)
        bottle.redirect("/welcome")
    else:
        return bottle.template("login",
                               dict(username=cgi.escape(username), password="",
                                    login_error="Invalid Login"))

@bottle.get('/internal_error')
@bottle.view('error_template')
def present_internal_error():
    return {'error':"System has encountered a DB error"}

@bottle.get('/logout')
def process_logout():
    cookie = bottle.request.get_cookie("session")
    sessions.end_session(cookie)
    bottle.response.set_cookie("session", "")
    bottle.redirect("/signup")

@bottle.post('/signup')
def process_signup():
    email = bottle.request.forms.get("email")
    username = bottle.request.forms.get("username")
    password = bottle.request.forms.get("password")
    verify = bottle.request.forms.get("verify")
    errors = {'username': cgi.escape(username), 'email': cgi.escape(email)}
    if validate_signup(username, password, verify, email, errors):
        if not users.add_user(username, password, email):
            errors['username_error'] = "Username already in use. Please choose another"
            return bottle.template("signup", errors)
        session_id = sessions.start_session(username)
        print session_id
        bottle.response.set_cookie("session", session_id)
        bottle.redirect("/welcome")
    else:
        print "user did not validate"
        return bottle.template("signup", errors)

@bottle.get("/welcome")
def present_welcome():
    cookie = bottle.request.get_cookie("session")
    username = sessions.get_username(cookie) 
    if username is None:
        print "welcome: can't identify user...redirecting to signup"
        bottle.redirect("/signup")
    return bottle.template("welcome", {'username': username})

def extract_tags(tags):
    whitespace = re.compile('\s')
    nowhite = whitespace.sub("",tags)
    tags_array = nowhite.split(',')
    cleaned = []
    for tag in tags_array:
        if tag not in cleaned and tag != "":
            cleaned.append(tag)
    return cleaned

def validate_signup(username, password, verify, email, errors):
    USER_RE = re.compile(r"^[a-zA-Z0-9_-]{3,20}$")
    PASS_RE = re.compile(r"^.{3,20}$")
    EMAIL_RE = re.compile(r"^[\S]+@[\S]+\.[\S]+$")
    errors['username_error'] = ""
    errors['password_error'] = ""
    errors['verify_error'] = ""
    errors['email_error'] = ""
    if not USER_RE.match(username):
        errors['username_error'] = "invalid username. try just letters and numbers"
        return False
    if not PASS_RE.match(password):
        errors['password_error'] = "invalid password."
        return False
    if password != verify:
        errors['verify_error'] = "password must match"
        return False
    if email != "":
        if not EMAIL_RE.match(email):
            errors['email_error'] = "invalid email address"
            return False
    return True

connection_string = "mongodb://localhost"
connection = pymongo.MongoClient(connection_string)
database = connection.blog
posts = blogPostDAO.BlogPostDAO(database)
users = userDAO.UserDAO(database)
sessions = sessionDAO.SessionDAO(database)

bottle.debug(True)
bottle.run(host='localhost', port=8082)