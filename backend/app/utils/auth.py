from aiohttp import web
import json
import jwt
import time
import aiomysql
import hashlib
from utils import mysql
secret = "2t4m8hbBgsQ2qJFi4BPmHQFoGqwINiZO"
tockens_mock = set()


def have_one_of_rights(right_set, right):
    if right in right_set:
        return True
    return False

def check_rights(fn):
    async def fn_wraper(*args, **kwargs):
        try:
            data = (await args[0].json())
            print("rights: " + str(jwt.decode(data["tocken"], secret,
                                              algorithm='HS256')))
            if not (sstr(jwt.decode(data["tocken"], secret, algorithm='HS256'))
                    == data["rights"]):
                raise jwt.exceptions.DecodeError
            print(str(data))
            print(str(kwargs))
            return await fn(*args, **kwargs)
        except jwt.exceptions.DecodeError:
            raise web.HTTPUnauthorized()
    return fn_wraper

def need_auth(fn):
    async def fn_wraper(*args, **kwargs):
        try:
            data = (await args[0].json())
            print("tocken data: " + str(jwt.decode(data["tocken"], secret,
                                                   algorithm='HS256')))
            del data["tocken"]
            print(str(data))
            print(str(kwargs))
            return await fn(*args, **kwargs)
        except jwt.exceptions.DecodeError:
            raise web.HTTPUnauthorized()
    return fn_wraper

def dev_login(data):
        cred_mock = {"menager1": {"password": "pass", "rights": "menager"},
                     "kucharz1": {"password": "pass", "rights": "kucharz"}, 
                     "kelner1": {"password": "pass", "rights": "kelner"}}
        login = data['login']
        password = data['password']
        if data['login'] in cred_mock and data['password'] == cred_mock[login]["password"]:
            tocken = jwt.encode({"login": data['login'], "rights":
                                 cred_mock[data['login']]["rights"], "password": cred_mock[login]["password"]}, secret, algorithm='HS256')
            tockens_mock.add(tocken)
            return {"rights": cred_mock[login]["rights"], "status": "Ok", "tocken": tocken.decode(), "username": login}
        return None

async def login(request):
    debug = True
    data = (await request.json())
    print(data)

    if debug:
        response = dev_login(data)
        if response is not None:
            return web.json_response(response)

    db = mysql.get_mysql_endpoint(request)
    login_ = data["login"]
    password = data["password"]
    print(f'SELECT * from `credentials` where `login` = "{login_}";')
    db_data = (await mysql.cursor_exec(db, f'SELECT * from `credentials` where `login` = "{login_}";'))[1][0]

    print(str(db_data[4]))
    password_hash = hashlib.md5(password.encode()).hexdigest()
    print(str(password_hash))

    if password_hash == db_data[4]:
        print("Password correct")
    response={}

    return web.json_response(data=response)

async def register(request):
    data = (await request.json())
    login = data["login"]
    password = data["password"]
    email = data["email"]
    print("login: " + login)
    print("password: " + password)
    print("email: " + email)
    userData = json.dumps({"password": password,
                           "email": email})
    return web.Response(text="Ok")
