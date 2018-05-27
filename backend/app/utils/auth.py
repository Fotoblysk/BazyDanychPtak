import settings
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
    if settings.DEBUG:
        print("Checking rights")

    async def fn_wraper(*args, **kwargs):
        try:
            data = (await args[0].json())
            if not (sstr(jwt.decode(data["tocken"], secret, algorithm='HS256'))
                    == data["rights"]):
                raise jwt.exceptions.DecodeError
            return await fn(*args, **kwargs)
        except jwt.exceptions.DecodeError:
            raise web.HTTPUnauthorized()
    return fn_wraper

def need_auth(fn):
    if settings.DEBUG:
        print("Auth checking")
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
    if settings.DEBUG:
        print("Dev login")

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
    if settings.DEBUG:
        print("Starting login")
    data = (await request.json())
    print(data)

    if settings.DEBUG:
        response = dev_login(data)
        if response is not None:
            return web.json_response(response)

    db = mysql.get_mysql_endpoint(request)
    login_ = data["login"]
    password = data["password"]

    try:
        db_data = (await mysql.cursor_exec(db, f'SELECT * from `credentials` where `login` = "%s";', login_))[1][0]
    except IndexError:
        if settings.DEBUG:
            print(f'No login data for {login_} in db')
        return web.json_response(data={"status": "login_invalid"})

    if password_hash == db_data[4]:
        if settings.DEBUG:
            tocken = jwt.encode({"login": data['login'], "rights":
                                 cred_mock[data['login']]["rights"], "password": cred_mock[login]["password"]}, secret, algorithm='HS256')
            expire_data = (timedelta.timedelta.now() + timedelta(days=2)).strfitme(MYSQL_TIMEDELTA_FORMAT)
            print(expire_data)
#            print(str(await mysql.cursor_exec(db, f"INSERT INTO `tockens` (`idtockens`, `credentials_idcredentials`, `tocken`, `expires`) VALUES ('3', '1', 'sadf', '2018-01-01 09:10:10');")))
            print("Password correct - returning ")
            return web.json_response(data=response)


    response={}

    return web.json_response(data=response)

async def register(request):
    if settings.DEBUG:
        print("Starting register")
    data = (await request.json())
    print(data)
    login = data["login"]
    password = data["password"]
    email = data["email"]
    print("login: " + login)
    print("password: " + password)
    print("email: " + email)
    userData = json.dumps({"password": password,
                           "email": email})
    return web.Response(text="Ok")
