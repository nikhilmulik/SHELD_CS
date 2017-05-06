from flask import Flask, jsonify, request, render_template, flash, redirect, url_for
from flask_socketio import SocketIO, emit
from flask_login import LoginManager, UserMixin, login_user, logout_user, current_user
from oauth import OAuthSignIn
import time

# from flask_bootstrap import Bootstrap
# from flask_wtf import FlaskForm
# from wtforms import StringField, PasswordField, BooleanField
# from wtforms.validators import InputRequired, Email, Length
# from werkzeug.security import generate_password_hash, check_password_hash
# from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user

from connect_db import ConnectDB
import simplejson
# import mysql.connector


from decimal import *

# import simplejson
# https://flask-socketio.readthedocs.io/en/latest/
# https://github.com/socketio/socket.io-client

app = Flask(__name__)

db = ConnectDB()


# app.config['SECRET_KEY'] = 'secretKey'
# Bootstrap(app)
socketio = SocketIO(app)
# login_manager = LoginManager()
# login_manager.init_app(app)
# login_manager.login_view = 'login'
# conn=mysql.connector.connect(user='root', password='password', host='localhost', database='shield')
# mycursor = conn.cursor()


# class LoginForm(FlaskForm):
#     username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
#     password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])
#     remember = BooleanField('remember me')
#
# class RegisterForm(FlaskForm):
#     email = StringField('email', validators=[InputRequired(), Email(message='Invalid email'), Length(max=50)])
#     username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
#     password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])

@app.route('/')
def cover():
    return render_template('index.html')


@app.route('/dashboard')
# @login_required
def dash():
    return render_template('dashboard/index.html')


def messageRecived():
    print('message was received-----!!!')


@socketio.on('my event')
def handle_my_custom_event(json):
    #print('received my event: ' + str(json))
    socketio.emit('my response', json, callback=messageRecived)


# @app.route('/api/post_klogs/<uid>', methods=['POST'])

@app.route('/api/post_keylogs/<machine_id>', methods=['POST'])
def post_keylog(machine_id):
    """
    check if valid uid, next of true
    :param uid:
    :return:
    """

    print request.json
    query = "INSERT INTO `shield`.`keylog` (`u_id`, `keylog_date_time`, `application_name`, `log_text`, `notification_id`, `unique_identifieri`) VALUES ({0},'{1}','{2}','{3}','{4}','{5}')".format(request.json['user_id'], request.json['datetime'], request.json['application'], request.json['data'], '0', machine_id);
    db_result = obj.execute_query(query)
    return jsonify({"uuid":machine_id})


# TONY's STUFF


@app.route('/login')
def login_page():
    return render_template('login.html')


@app.route('/api_login/', methods=['POST'])
def login_check():
    '''
    you will get the user id and password here
    :return:
    '''
    result = {}
    request_data = request.json
    username = request_data['inputUsername']
    password = request_data['inputPassword']
    data = db.select("login", {"username": username, "password": password})
    if data:
        result['u_id'] = data[0][0]
        result['username'] = data[0][1]
        return simplejson.dumps(result)
    else:
        return "Error"


    # you get the data in json form, please process the data from here



    # query = 'SELECT FirstName,LastName, Address, City, State, Country, PostalCode, Phone, Fax, Email ' \
    #         'FROM employee WHERE Email= "'+request_data['inputPassword']+'"'
    # db_result = obj.execute_query(query)
    # result['db_result'] = db_result[0]
    # if request_data['inputPassword'] == 'andrew@chinookcorp.com':
    #     result['permission'] = 'admin'
    # else:
    #     result['permission'] = 'user'
    return 'Send Acknowledgement'

######################################### Sid's Code

lm = LoginManager(app)
lm.login_view = 'login'

# @lm.user_loader
# def load_user(id):
#     return User.query.get(int(id))

@app.route('/authorize/<provider>')
def oauth_authorize(provider):
    if not current_user.is_anonymous:
        return redirect(url_for('login_page'))
    oauth = OAuthSignIn.get_provider(provider)
    return oauth.authorize()

# Valid OAuth URI specified in the FB app : http://localhost:5000/callback/facebook/
@app.route('/callback/<provider>')
def oauth_callback(provider):
    if not current_user.is_anonymous:
        return redirect(url_for('login_page'))
    oauth = OAuthSignIn.get_provider(provider)
    social_id, username, email = oauth.callback()
    if social_id is None:
        flash('Authentication failed.')
        return redirect(url_for('login_page'))
    # print social_id, username, email
    # table = "login"
    fb_details = {'username': username,
         'auth_token': social_id,
         'login_source': provider,
         'email_id': email
    }
    # result = obj.insert(table, data)
    entry = db.select('login', {'username': username})
    if entry:
        print 'Record Exists: ' + str(entry)
        return redirect(url_for('dash'))
    # SELECT username from login where username = 'dunkdude17';
    query = "INSERT INTO `shield`.`login` (`username`, `email_id`, `auth_token`, `login_source`) " \
            "VALUES ('"+ fb_details['username'] +"', '" + fb_details['email_id'] + "', '" + fb_details['auth_token'] + "', '" + fb_details['login_source'] + "');"
    result = db.execute_query(query)
    # result = db.insert('login', fb_details)
    print result
    return redirect(url_for('dash'))

    # print username, social_id, email, provider
    # return redirect(url_for('dash'))

    # result = {}
    # request_data = request.json
    # username = request_data['inputUsername']
    # password = request_data['inputPassword']
    # data = obj.select("login", {"username": username, "password": password})
    # if data:
    #     result['u_id'] = data[0][0]
    #     result['username'] = data[0][1]
    #     return simplejson.dumps(result)
    # else:
    #     return "Error"


################################################ Sid's code ends

# def login():
#
#
#     # form = LoginForm()
#
#     # if form.validate_on_submit():
#         # username = form.username.data
#         # password = form.password.data
#
#         # result = mycursor.execute("SELECT Username, Password FROM shield.login WHERE Username = %s and Password = %s", (username, password))
#         #
#         # for row in result.fetchall():
#         #     print row
#         # import pdb; pdb.set_trace()
#
#         # result = obj.select("shield.login", {'Username': username, 'Password': password});
#         # print(result)
#
#         # return redirect('http://127.0.0.1:5000/dashboard')
#
#         # return '<h1>Invalid username or password</h1>'
#
#     return render_template('login.html', form=form)

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    # form = RegisterForm()

    # if form.validate_on_submit():
        # username = form.username.data
        # email = form.email.data
        # password = form.password.data
        # hashed_password = generate_password_hash(form.password.data, method='sha256')
        # try:
        #     mycursor.execute("INSERT INTO shield.login (Username, Password) VALUES (%s,%s)", (username, password))
        #     conn.commit()
        # except:
        #     conn.rollback()

        return render_template('child.html') #'<h1>New user has been created!</h1>'

    # return render_template('signup.html', form='')


@app.route('/getKeylogData')
# @login_required
def getKeyLogData():
    # import pdb;
    # pdb.set_trace();
    tuples = obj.select('keylog', {'u_id': '3'})
    # res[0][1] = str(res[0][1])
    result = []
    tuplesList = list(tuples)

    for tup in tuplesList:
        tupleData = list(tup)
        tupleData[1] = str(tupleData[1])

        result.append(tupleData)

    return simplejson.dumps(result)

@app.route('/get_profile')
# @login_required
def getProfile():
    # import pdb;
    # pdb.set_trace();
    tuples = db.select('user_profile', {'u_id': '1'})
    # res[0][1] = str(res[0][1])
    result = []
    # tuplesList = list(tuples)
    #
    # for tup in tuplesList:
    #     tupleData = list(tup)
    #     tupleData[1] = str(tupleData[1])
    #
    #     result.append(tupleData)

    return simplejson.dumps(tuples)


@app.route('/logout')
# @login_required
def logout():
    logout_user()
    return redirect(url_for('index'))


# import random
# hash = random.getrandbits(128)
# print "hash value: %032x" % hash



if __name__ == "__main__":
    app.debug = True
    socketio.run(app)
