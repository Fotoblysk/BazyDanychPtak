import db
from aiohttp import web
import json
import jwt
import time
secret = "2t4m8hbBgsQ2qJFi4BPmHQFoGqwINiZO"
tockens = set()


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

async def login(request):
    data = (await request.json())
    login = data["login"]
    password = data["password"]
    cred_mock = {"menager1": {"password": "pass", "rights": "menager"}, # demo hack
                 "kucharz1": {"password": "pass", "rights": "kucharz"}, 
                 "kelner1": {"password": "pass", "rights": "kelner"}}
    print("lol")
    print(login)
    if login in cred_mock and password == cred_mock[login]["password"]:
        tocken = jwt.encode({"login": login, "rights":
                             cred_mock[login]["rights"], "password": cred_mock[login]["password"]}, secret, algorithm='HS256')
        tockens.add(tocken)
        return web.json_response(
            #data={"status": "Ok", "tocken": tocken.decode()}
            data={"rights": cred_mock[login]["rights"], "status": "Ok", "tocken": tocken.decode(), "username": login} # demo hack
        )
    else:
        return web.json_response(
            data={"status": "Bad"}
        )

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
