import settings
from aiohttp import web
import json
import jwt
import time
import datetime
import aiomysql
import hashlib
from utils import mysql
from utils import utils
import os
import crypt
secret = "2t4m8hbBgsQ2qJFi4BPmHQFoGqwINiZO"
tockens_mock = set()


def login_required(fn):
    if settings.DEBUG:
        print("Checking rights")
    async def fn_wraper(*args, **kwargs):
        try:
            data = (await args[0].json())
            jwt.decode(data["tocken"], secret, algorithm='HS256')
            return await fn(*args, **kwargs)
        except jwt.exceptions.DecodeError:
            raise web.HTTPUnauthorized()
    return fn_wraper

def check_rights(fn):
    if settings.DEBUG:
        print("Checking rights")
    async def fn_wraper(*args, **kwargs):
        try:
            data = (await args[0].json())
            if not str(jwt.decode(data["tocken"], secret, algorithm='HS256')) == data["rights"]:
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

    utils.validate_login(login_)

    password_ = data["password"]

    try:
        db_data = (await mysql.cursor_exec(db, f'SELECT `password_hash`, `salt`, `idcredentials`  from `credentials` where `login` = %s;', login_))[1][0]
    except IndexError:
        if settings.DEBUG:
            print(f'No login data for {login_} in db')
        return web.json_response(data={"status": "login_invalid"})

    db_password_hash = db_data[0]
    db_password_salt = db_data[1]
    password_hash = hashlib.md5((password_ + db_password_salt).encode())
    db_credid = db_data[2]
    response=None
    if password_hash.hexdigest() == db_password_hash:
        expire_data = (datetime.datetime.now() + datetime.timedelta(days=2)).strftime(mysql.MYSQL_TIMEDELTA_FORMAT)
        tocken = jwt.encode({"login": login_, "rights": "menager", "password_hash": db_password_hash, "expires": expire_data}, secret, algorithm='HS256')
        tocken_md5 = hashlib.md5(tocken).hexdigest()
        await mysql.cursor_exec(db,
            f"INSERT INTO `main`.`tockens` (`credentials_idcredentials`, `tocken`, `expires`) VALUES ('{db_credid}', '{tocken_md5}', '{expire_data}');")
        print("Password correct - returning ")
        response={"rights": "menager", "status": "Ok", "tocken": tocken.decode(), "username": login_}
    else:
        response={"status": "bad_password"}

    return web.json_response(data=response)

async def register(request):
    if settings.DEBUG:
        print("Starting register")
    data = (await request.json())
    print(data)
    login = data["login"]
    password = data["password"]
    email = data["email"]
    id_pracownika = data["id_pracownika"]
    utils.validate_int(id_pracownika)
    utils.validate_email(email)
    utils.validate_login(login)
    salt = crypt.mksalt(crypt.METHOD_MD5)
    password_hash = hashlib.md5((password + salt).encode()).hexdigest()
    db = mysql.get_mysql_endpoint(request)
    await mysql.cursor_exec(db,
        f"INSERT INTO `main`.`credentials` (`employees_idemployees`, `login`, `email`, `password_hash`, `active`, `salt`) VALUES (%s, %s, %s, %s, '0', '{salt}');", id_pracownika, login, email, password_hash)

    return web.Response(text="Ok")
