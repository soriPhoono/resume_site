'''
init file for static website
'''
from flask import Flask, render_template

app = Flask(__name__)


# @app.route('/')
# def index():
#     '''
#     index page
#     '''
#     return render_template('index.html')


@app.route('/about')
def about():
    '''
    about page for personal information
    '''
    return render_template('about.html')
