import json
from db2 import db, User, Location, Chats, Posts
from flask import Flask, request

app = Flask(__name__)
db_filename = 'todo.db'

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///%s' % db_filename
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

db.init_app(app)
with app.app_context():
    db.drop_all()
    db.create_all()
    #create_a_user({"netid": "abc123", "name": "sd"})



@app.route('/')

@app.route('/api/users/')
def get_users():
    users = User.query.all()
    res = {'success': True, 'data': [u.serialize() for u in users]}
    return json.dumps(res), 200

@app.route('/api/user/', methods = ['POST'])
def create_a_user():
    body = json.loads(request.data)
    user = User(
        netid = body.get('netid'),
        name = body.get('name')
    )
    db.session.add(user)
    db.session.commit()
    return json.dumps({'success': True, 'data': user.serialize()}), 201

@app.route('/api/user/<path:netid>/')
def get_a_user(netid):
    u = User.query.filter_by(netid = netid).first()
    if u is not None:
        return json.dumps({'success': True, 'data': u.serialize()}),200
    return json.dumps({'success': False, 'error': 'class not found!'}),404

@app.route('/api/user/<path:netid>/', methods = ['DELETE'])
def delete_user(netid):
    u = User.query.filter_by(netid = netid).first()
    if u is not None:
        db.session.delete(u)
        db.session.commit()
        return json.dumps({'success': True, 'data': u.serialize()}),200
    return json.dumps({'success': False, 'error': 'User not found!'}),404
"""
@app.route('/api/locations/', methods = ['POST'])
def create_a_location():
    body = json.loads(request.data)
    location = Location(
        name = user_body.get('location_name'),
    )
    db.session.add(location)
    db.session.commit()
    return json.dumps({'success': True, 'data': location.serialize()}), 201
"""
@app.route('/api/user/<path:netid>/locations/')
def get_favorite_location(netid):
    u = User.query.filter_by(netid = netid).first()
    if u is not None:
        locations = [l.serialize() for l in u.favo_location]
        return json.dumps({'success': True, 'data': locations}),200
    return json.dumps({'success': False, 'error': 'User not found!'}),404

@app.route('/api/user/<path:netid>/location/', methods = ['POST'])
def create_favo_location(netid):
    u = User.query.filter_by(netid = netid).first()
    if u is not None:
        user_id = u.id
        body = json.loads(request.data)
        location = Location(
            name = body.get('location_name'),
            user_id = user_id
        )
        u.favo_location.append(location)
        db.session.add(location)
        db.session.commit()
        return json.dumps({'success': True, 'data': location.serialize()}), 201
    return json.dumps({'success': False, 'error': 'User not found!'}),404
"""
@app.route('/api/user/<path:netid>/', methods = ['DELETE'])
def delete_favo_location(netid):
    user = User.query.filter_by(netid = netid).first()
    if user is not None:
        user_id = user.id
        favo_location = user.favo_location
        if favo_location is not None:
            db.session.delete(favo_location)
            db.session.commit()
            return json.dumps({'success': True, 'data': post.serialize()}),200
    return json.dumps({'success': False, 'error': 'User/Location not found!'}),404
"""
@app.route('/api/user/<path:netid>/location/<string:location_name>/',methods=['DELETE'])
def delete_a_location(netid, location_name):
    """
    Delete and return the location of the user
    """
    user = User.query.filter_by(netid = netid).first()
    if user is not None:
        user_id = user.id
        location_list = []
        for location_n in Location.query.filter_by(user_id = user_id).all():
            location_ = Location.query.filter_by(name = location_n).first()
            if location_ is not None:
                location_list.append(location_)
                db.session.delete(favo_location)
                db.session.commit()
        return json.dumps({'success': True, 'data': [l.serialize() for l in location_list]}), 200
    return json.dumps({'success': False, 'error': 'User/Location not found!'}),404

#--------------------------------------------------------------------------------------------
@app.route('/api/chats/')
def get_chats():
    chats = Chats.query.all()
    res = {'success': True, 'data': [chat.serialize() for chat in chats]}
    return json.dumps(res), 200

@app.route('/api/chats/', methods = ['POST'])
def create_chat():
    chat_body = json.loads(request.data)
    chat_name = chat_body.get('chat_name')
    if (get_a_chat(chat_name) == null):
        chat = Chats(
            chat_name = chat_name
        )
        db.session.add(chat)
        db.session.commit()
        return json.dumps({'success': True, 'data': chat.serialize()}), 201

@app.route('/api/chat/<string:chatname>/')
def get_a_chat(chatname):
    chat = Chats.query.filter_by(chat_name = chatname).first()
    if chat is not None:
        return json.dumps({'success': True, 'data': chat.serialize()}),200
    return json.dumps({'success': False, 'error': 'Chatting not found!'}),404

@app.route('/api/chat/<string:chat_name>/posts/')
def get_posts(chat_name):
    chat = Chats.query.filter_by(chat_name = chat_name).first()
    if chat is not None:
        post = [post.serialize() for post in chat.posts]
        return json.dumps({'success': True, 'data': post}),200
    return json.dumps({'success': False, 'error': 'Chat not found!'}),404


@app.route('/api/chat/<string:chat_name>/post/<string:netid>/', methods = ['POST'])

def create_post(chat_name,netid):
    chat = Chats.query.filter_by(chat_name = chat_name).first()
    if chat is not None:
        post_body = json.loads(request.data)
        u = User.query.filter_by(netid = netid).first()
        post = Posts(
            text = post_body.get('text'),
            netid = netid,
            chatname = chat.chat_name,
            chat_id = chat.id,
            username = u.name,
            user_netid = netid
        )
        chat.posts.append(post)
        db.session.add(post)
        db.session.commit()
        return json.dumps({'success': True, 'data': post.serialize()}), 201
    return json.dumps({'success': False, 'error': 'Chats not found!'}), 404


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

