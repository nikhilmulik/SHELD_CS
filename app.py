from flask import Flask, jsonify, request, render_template, flash, redirect, url_for
from flask_socketio import SocketIO, emit
from flask_login import LoginManager, UserMixin, login_user, logout_user, current_user
from oauth import OAuthSignIn


# from flask_bootstrap import Bootstrap
# from flask_wtf import FlaskForm
# from wtforms import StringField, PasswordField, BooleanField
# from wtforms.validators import InputRequired, Email, Length
# from werkzeug.security import generate_password_hash, check_password_hash
# from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
# from connect_db import ConnectDB

# import mysql.connector

from decimal import *

# import simplejson
# https://flask-socketio.readthedocs.io/en/latest/
# https://github.com/socketio/socket.io-client

app = Flask(__name__)
# obj = ConnectDB()

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

@app.route('/api/post_keylogs/<uid>', methods=['POST'])
def add_message(uid):
    """
    check if valid uid, next of true
    :param uid:
    :return:
    """
    # import pdb; pdb.set_trace()
    # content = request.json
    print uid
    print request.json
    return jsonify({"uuid":uid})


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
    print username, password

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


# from flask_login import LoginManager, UserMixin, login_user, logout_user,\
#     current_user


# app = Flask(__name__)
# app.config['SECRET_KEY'] = 'top secret!'
#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///db.sqlite'
# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:_Fedora25@localhost/testdb'
# app.config['OAUTH_CREDENTIALS'] = {
#     'facebook': {
#
#         'id': '277308882695364',
#         'secret': '949643620832ced50226022166416435'
#
#     }
#  'twitter': {
 #       'id': '3RzWQclolxWZIMq5LJqzRZPTl',
  #      'secret': 'm9TEd58DSEtRrZHpz2EjrV9AhsBRxKMo8m3kuIZj3zLwzwIimt'
   # }
# }

# db = SQLAlchemy(app)
lm = LoginManager(app)
lm.login_view = 'login'


# class User(UserMixin, db.Model):
#     __tablename__ = 'users'
#     id = db.Column(db.Integer, primary_key=True)
#     social_id = db.Column(db.String(64), nullable=False, unique=True)
#     nickname = db.Column(db.String(64), nullable=False)
#     email = db.Column(db.String(64), nullable=True)


# @lm.user_loader
# def load_user(id):
#     return User.query.get(int(id))

# @app.route('/logout')
# def logout():
#     logout_user()
#     return redirect(url_for('first'))


@app.route('/authorize/<provider>')
def oauth_authorize(provider):
    if not current_user.is_anonymous:
        return redirect(url_for('login_page'))
    oauth = OAuthSignIn.get_provider(provider)
    return oauth.authorize()


@app.route('/callback/<provider>')
def oauth_callback(provider):
    if not current_user.is_anonymous:
        return redirect(url_for('first'))
    oauth = OAuthSignIn.get_provider(provider)
    social_id, username, email = oauth.callback()
    if social_id is None:
        flash('Authentication failed.')
        return redirect(url_for('login_page'))
    # user = User.query.filter_by(social_id=social_id).first()
    # if not user:
        # user = User(social_id=social_id, username=username, email=email)
    # user = (username, social_id, email)
    print username, social_id, email
        # db.session.fadd(user)
        # db.session.commit()
    # login_user(user, True)
    return redirect(url_for('dash'))

{"username": nickname, "email": email}

# if __name__ == '__main__':
#     # db.create_all()
#     app.run(debug=True)

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


@app.route('/logout')
# @login_required
def logout():
    # logout_user()
    return redirect(url_for('index'))


if __name__ == "__main__":
    app.debug = True
    socketio.run(app)