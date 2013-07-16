# -*- coding: utf-8 -*-
import bottle
import bottle.ext.sqlite
from bottle import template, request, redirect
from beaker.middleware import SessionMiddleware
import json

app = bottle.app()
plugin = bottle.ext.sqlite.Plugin(dbfile='votes.db')
app.install(plugin)

session_opts = {
    'session.type': 'file',
    'session.cookie_expires': 300,
    'session.data_dir': './data',
    'session.auto': True
}
app = SessionMiddleware(app, session_opts)

@bottle.get('/users/new')
def user_new():
    return template('users_new', message='')
 
@bottle.post('/users/new')
def add_user(db):
    email = request.forms.get('email')
    password = request.forms.get('password')
    user = db.execute('select * from users where email=?', [email]).fetchone()
    if user:
        message = email + ' is already exist.'
        return template('users_new', message = message)
    db.text_factory = str
    db.execute('insert into users (email, password) values (?, ?);', [email, password])
    return 'OK'

@bottle.get('/users/login')
def users_login():
    to = request.query.get('to', '')
    return template('users_login', to=to, message='')

def set_user_id(request, user_id):
    s = request.environ.get('beaker.session')
    s['user_id'] = user_id
    s.save()

@bottle.post('/users/login')
def login(db):
    email = request.forms.get('email')
    password = request.forms.get('password')
    to = request.forms.get('to')
    user = db.execute('select * from users where email=? and password=?', [email, password]).fetchone()
    if user:
        set_user_id(request, user['id'])
        if to:
            redirect(to)
        return 'Logged In.'
    else:
        message = 'Invalid email or password.'
        return template('users_login', to=to, message = message)

@bottle.get('/users/logout')
def users_logout(db):
    user_id, email, password = get_user_info(request, db)
    if user_id:
        return template('users_logout')
    return 'Logout'

@bottle.post('/users/logout')
def logout(db):
    user_id, email, password = get_user_info(request, db)
    if user_id:
        set_user_id(request, None)
    return 'Logout'

def get_user_info(request, db):
    user_id = request.environ.get('beaker.session').get('user_id')
    user = db.execute('select * from users where id=?', [user_id]).fetchone()
    if user:
        return user['id'], user['email'], user['password']
    return None, None, None

@bottle.get('/users/update')
def users_update(db):
    user_id, email, password = get_user_info(request, db)
    if user_id:
        return template('users_update', email=email, password=password, message='')
    else:
        redirect('/users/login?to=/users/update')

@bottle.post('/users/update')
def update_user(db):
    user_id, old_email, old_password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/users/update')
    email = request.forms.get('email')
    password = request.forms.get('password')
    db.text_factory = str
    db.execute('update users set email=?, password=? where id=?', [email, password, user_id]);
    return 'Updated.'

@bottle.get('/events/new')
def events_new(db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/events/new')
    return template('events_new', message='')

@bottle.post('/events/new')
def add_event(db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/events/new')
    name = request.forms.get('name')
    desc = request.forms.get('description')
    user_score = request.forms.get('user_score', 0)
    team_score = request.forms.get('team_score', 0)
    db.text_factory = str
    db.execute('insert into events (name, description, user_score, team_score) values (?, ?, ?, ?);', [name, desc, user_score, team_score])
    redirect('/events/list')
    
@bottle.get('/events/list')
@bottle.get('/')
def events_list(db):
    events = db.execute('select * from events').fetchall()
    return template('events_list', events=events)

@bottle.get('/events/show/:id')
def events_show(id, db):
    my_team_id = None
    user_id, email, password = get_user_info(request, db)
    event = db.execute('select * from events where id=?', id).fetchone()
    if user_id:
        my_votes = db.execute('select * from teams left outer join votes on teams.id = votes.team_id where teams.event_id=?', [id]).fetchall()
        return template('events_show', id=event['id'], name=event['name'], description=event['description'], teams=my_votes)
    else:
        teams = db.execute('select * from teams where event_id=?', [id]).fetchall()
        return template('events_show_no_auth', id=event['id'], name=event['name'], description=event['description'], teams=teams)
    
@bottle.get('/events/result/<event_id>.json')
def events_result(event_id, db):
    teams = db.execute('select * from teams left outer join votes on teams.id = votes.team_id where teams.event_id=?', [event_id]).fetchall()
    team_json = []
    for team in teams:
        if team['name']:
            score = 0
            if team['score']:
                score = team['score']
            team_json.append('{name: "' + team['name'] + '", score: "' + str(score) + '"}')
    callback = request.query.get('callback', 'callback') + '(['
    return callback + ','.join(team_json) + '])'

@bottle.get('/events/update/:id')
def events_update(id, db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/events/update/' + id)
    event = db.execute('select * from events where id=?', id).fetchone()
    return template('events_update', event=event, message='')

@bottle.post('/events/update/:id')
def update_event(id, db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/events/update/' + id)
    name = request.forms.get('name')
    desc = request.forms.get('description')
    user_score = request.forms.get('user_score')
    team_score = request.forms.get('team_score')
    db.text_factory = str
    db.execute('update events set name=?, description=?, user_score=?, team_score=? where id=?', [name, desc, user_score, team_score, id])
    redirect('/events/show/' + id)
 
@bottle.get('/teams/new/:event_id')
def teams_new(event_id, db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/teams/new')
    event = db.execute('select * from events where id=?', event_id).fetchone()
    return template('teams_new', event_id=event['id'], event_name=event['name'], message='')

@bottle.post('/teams/new/:event_id')
def add_team(event_id, db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/teams/new/' + event_id)
    event = db.execute('select * from events where id=?', event_id).fetchone()
    if not event:
        return 'Invalid event.'
    name = request.forms.get('name')
    desc = request.forms.get('description')
    db.text_factory = str
    db.execute('insert into teams (name, description, event_id) values (?, ?, ?);', [name, desc, event_id])
    redirect('/events/show/' + event_id)

@bottle.post('/users/vote/:event_id/:team_id/:score')
def vote(event_id, team_id, score, db):
    user_id, email, password = get_user_info(request, db)
    if not user_id:
        redirect('/users/login?to=/events/show/' + event_id)
    team = db.execute('select * from teams where id=?', [team_id]).fetchone()
    if not team:
        return 'Invalid team.'
    event = db.execute('select * from events where id=?', [team['event_id']]).fetchone()
    if not event:
        return 'Invalid event.'
    user_score = db.execute('select total(score) from votes where user_id=? and event_id=?', [user_id, event_id]).fetchone()[0]
    team_score = db.execute('select total(score) from votes where user_id=? and event_id=? and team_id=?', [user_id, event_id, team_id]).fetchone()[0]
    if user_score - team_score + int(score) > event['user_score']:
        return 'Exceeds total score ' + str(event['user_score'])
    if int(score) > event['team_score']:
        return 'Exceeds team score ' + str(event['team_score'])
    vote = db.execute('select * from votes where user_id=? and team_id=?', [user_id, team_id]).fetchone()
    db.text_factory = str
    if vote:
        db.execute('update votes set score=? where id=?', [score, vote['id']])
    else:
        db.execute('insert into votes (user_id, event_id, team_id, score) values (?, ?, ?, ?)', [user_id, event_id, team_id, score])
    redirect('/events/show/' + event_id)

bottle.run(app=app, host='0.0.0.0', port=8080, debug=True, reloader=True)
