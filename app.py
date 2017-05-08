from flask import Flask, jsonify, request, render_template, flash, redirect, url_for
from flask_socketio import SocketIO, emit
from flask_login import LoginManager, UserMixin, login_user, logout_user, current_user
from oauth import OAuthSignIn
import json
from connect_db import ConnectDB
import simplejson
# import mysql.connector

# https://flask-socketio.readthedocs.io/en/latest/
# https://github.com/socketio/socket.io-client

app = Flask(__name__)
db = ConnectDB()
global super_var
socketio = SocketIO(app)


@app.route('/')
def cover():
    return render_template('index.html')


@app.route('/dashboard')
# @login_required
def dash(data=None):
    data = eval(request.args['messages'])
    messages = {'u_id': data[0], 'username': data[1], 'auth_token': data[3], 'login_source': data[4], 'email_id': data[5]}
    # import pdb; pdb.set_trace()
    return render_template('dashboard/index.html', data=messages)


def messageRecived():
    print('message was received-----!!!')


@socketio.on('my event')
def handle_my_custom_event(json):
    #print('received my event: ' + str(json))

    socketio.emit('my response', json, callback=messageRecived)

@socketio.on('key_log')
def dbInsert():
    #print('received my event: ' + str(json))
    socketio.emit('key_log_in', {'insert': 'true'}, callback=messageRecived)


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
    db_result = db.execute_query(query)
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
        # return dash(entry)
        return redirect(url_for('dash', messages=entry))
    # SELECT username from login where username = 'dunkdude17';
    query = "INSERT INTO `shield`.`login` (`username`, `email_id`, `auth_token`, `login_source`) " \
            "VALUES ('"+ fb_details['username'] +"', '" + fb_details['email_id'] + "', '" + fb_details['auth_token'] + "', '" + fb_details['login_source'] + "');"
    result = db.execute_query(query)
    return redirect(url_for('dash', messages=result))
    # return dash(result)



################################################ Sid's code ends


# @app.route('/signup', methods=['GET', 'POST'])
# def signup():
#     # form = RegisterForm()
#
#     # if form.validate_on_submit():
#         # username = form.username.data
#         # email = form.email.data
#         # password = form.password.data
#         # hashed_password = generate_password_hash(form.password.data, method='sha256')
#         # try:
#         #     mycursor.execute("INSERT INTO shield.login (Username, Password) VALUES (%s,%s)", (username, password))
#         #     conn.commit()
#         # except:
#         #     conn.rollback()
#
#         return render_template('child.html') #'<h1>New user has been created!</h1>'
#
#     # return render_template('signup.html', form='')


@app.route('/getKeylogData/<user_id>')
def getKeyLogData(user_id):
    # import pdb; pdb.set_trace()
    tuples = db.select('keylog', {'u_id': user_id})
    # res[0][1] = str(res[0][1])
    result = []
    tuplesList = list(tuples)
    for tup in tuplesList:
        tupleData = list(tup)
        tupleData[1] = str(tupleData[1])

        result.append(tupleData)

    return simplejson.dumps(result)

@app.route('/get_profile/<user_id>')
# @login_required

def getProfile(user_id):
    tuples = db.select('user_profile', {'u_id': user_id})

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
def logout():
    logout_user()
    return redirect(url_for('index'))


# import random
# hash = random.getrandbits(128)
# print "hash value: %032x" % hash



if __name__ == "__main__":
    app.debug = True
    socketio.run(app)
