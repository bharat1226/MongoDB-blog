#written by golib

import sys
import random
import string

__author__ = 'golib'

class SessionDAO:
    def __init__(self, database):
        self.db = database
        self.sessions = database.sessions
    def start_session(self, username):
        session_id = self.get_random_str(32)
        session = {'username': username, '_id': session_id}
        try:
            self.sessions.insert_one(session)
        except:
            print "Unexpected error on start_session:", sys.exc_info()[0]
            return None
        return str(session['_id'])

    def end_session(self, session_id):
        if session_id is None:
            return
        self.sessions.delete_one({'_id': session_id})
        return

    def get_session(self, session_id):
        if session_id is None:
            return None
        session = self.sessions.find_one({'_id': session_id})
        return session

    def get_username(self, session_id):
        session = self.get_session(session_id)
        if session is None:
            return None
        else:
            return session['username']

    def get_random_str(self, num_chars):
        random_string = ""
        for i in range(num_chars):
            random_string = random_string + random.choice(string.ascii_letters)
        return random_string
