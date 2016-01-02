#written by golib

import sys
import re
import datetime

__author__ = 'golib'

class BlogPostDAO:
    def __init__(self, database):
        self.db = database
        self.posts = database.posts

    def insert_entry(self, title, post, tags_array, author):
        print "inserting blog entry", title, post
        exp = re.compile('\W') 
        whitespace = re.compile('\s')
        temp_title = whitespace.sub("_",title)
        permalink = exp.sub('', temp_title)
        post = {"title": title,
                "author": author,
                "body": post,
                "permalink":permalink,
                "tags": tags_array,
                "comments": [],
                "date": datetime.datetime.utcnow()}
        try:
            self.posts.insert(post)
            print "Inserting the post"
        except:
            print "Error inserting post"
            print "Unexpected error:", sys.exc_info()[0]
        return permalink

    def get_posts(self, num_posts):
        cursor = self.posts.find().sort('date', direction=-1).limit(num_posts)
        l = []
        for post in cursor:
            post['date'] = post['date'].strftime("%A, %B %d %Y at %I:%M%p") 
            if 'tags' not in post:
                post['tags'] = [] 
            if 'comments' not in post:
                post['comments'] = []
            l.append({'title':post['title'], 'body':post['body'], 'post_date':post['date'],
                      'permalink':post['permalink'],
                      'tags':post['tags'],
                      'author':post['author'],
                      'comments':post['comments']})
        return l

    def get_posts_by_tag(self, tag, num_posts):
        cursor = self.posts.find({'tags':tag}).sort('date', direction=-1).limit(num_posts)
        l = []
        for post in cursor:
            post['date'] = post['date'].strftime("%A, %B %d %Y at %I:%M%p")    
            if 'tags' not in post:
                post['tags'] = []          
            if 'comments' not in post:
                post['comments'] = []
            l.append({'title': post['title'], 'body': post['body'], 'post_date': post['date'],
                      'permalink': post['permalink'],
                      'tags': post['tags'],
                      'author': post['author'],
                      'comments': post['comments']})
        return l

    def get_post_by_permalink(self, permalink):
        post = self.posts.find_one({'permalink': permalink})
        if post is not None:
            for comment in post['comments']:
                if 'num_likes' not in comment:
                    comment['num_likes'] = 0
                elif isinstance(comment['num_likes'], float) and comment['num_likes'].is_integer():
                    comment['num_likes'] = int(comment['num_likes'])           
            post['date'] = post['date'].strftime("%A, %B %d %Y at %I:%M%p")
        return post

    def add_comment(self, permalink, name, email, body):
        comment = {'author': name, 'body': body}
        if (email != ""):
            comment['email'] = email
        try:
            last_error = self.posts.update({'permalink': permalink}, {'$push': {'comments': comment}})
            return last_error['n']    
        except:
            print "Could not update the collection, error"
            print "Unexpected error:", sys.exc_info()[0]
            return 0

    def increment_likes(self, permalink, comment_ordinal):
        post = self.posts.find_one({'permalink': permalink})
        if post is not None:
            for i, comment in enumerate(post['comments']):
                if i == comment_ordinal:
                    if 'num_likes' not in comment:
                        comment['num_likes'] = 1
                    else:
                        comment['num_likes'] = comment['num_likes'] + 1
            self.posts.update({'permalink': permalink}, post)
        return 0
