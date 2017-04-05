from flask import Flask, jsonify, request
from flask import render_template

from decimal import *

import simplejson

app = Flask(__name__)


@app.route('/')
def cover():
    return render_template('index.html')


# @app.route('/api/post_klogs/<uid>', methods=['POST'])
@app.route('/api/post_keylogs/', methods=['POST'])
def add_message(uid):
    """
    check if valid uid, next of true
    :param uid:
    :return:
    """
    # import pdb; pdb.set_trace()
    # content = request.json
    print request.data
    # print content
    return jsonify({"uuid":uid})






if __name__ == "__main__":
    app.debug = True
    app.run()



