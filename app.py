from flask import Flask, jsonify, request
from flask import render_template
from flask_socketio import SocketIO, emit
from flask import Flask, render_template, redirect, url_for
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField
from wtforms.validators import InputRequired, Email, Length
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
import mysql.connector

from decimal import *

# import simplejson
# https://flask-socketio.readthedocs.io/en/latest/
# https://github.com/socketio/socket.io-client

app = Flask(__name__)

app.config['SECRET_KEY'] = 'secretKey'
Bootstrap(app)
socketio = SocketIO(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'
conn=mysql.connector.connect(user='root', password='Mysql123@#', host='localhost', database='shield')
mycursor = conn.cursor()


class LoginForm(FlaskForm):
    username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
    password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])
    remember = BooleanField('remember me')

class RegisterForm(FlaskForm):
    email = StringField('email', validators=[InputRequired(), Email(message='Invalid email'), Length(max=50)])
    username = StringField('username', validators=[InputRequired(), Length(min=4, max=15)])
    password = PasswordField('password', validators=[InputRequired(), Length(min=8, max=80)])

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

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()

    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user:
            if check_password_hash(user.password, form.password.data):
                login_user(user, remember=form.remember.data)
                return redirect(url_for('dashboard'))

        return '<h1>Invalid username or password</h1>'

    return render_template('login.html', form=form)

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    form = RegisterForm()

    if form.validate_on_submit():
        username = form.username.data
        # email = form.email.data
        password = form.password.data
        # hashed_password = generate_password_hash(form.password.data, method='sha256')
        try:
            mycursor.execute("INSERT INTO sheild.login (Username, Password) VALUES (%s,%s)", (username, password))
            conn.commit()
        except:
            conn.rollback()

        return '<h1>New user has been created!</h1>'

    return render_template('signup.html', form=form)


@app.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('index'))


if __name__ == "__main__":
    app.debug = True
    socketio.run(app)