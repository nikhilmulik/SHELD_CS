from flask import Flask, jsonify, request
from flask import render_template

from decimal import *

import simplejson

app = Flask(__name__)


@app.route('/')
def cover():
    return render_template('index.html')





if __name__ == "__main__":
    app.debug = True
    app.run()



