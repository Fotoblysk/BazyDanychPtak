import aiohttp
import re
def validate_int(number):
    try:
       val = int(number)
    except ValueError:
        print("number is not int")
        raise aiohttp.web.HTTPBadRequest()

def validate_email(email):
    if not re.match(r"[^@]+@[^@]+\.[^@]+", email):
        print("email is not valid")
        raise aiohttp.web.HTTPBadRequest()
    else:
        print("pass")

def validate_login(login):
    if not re.match(r"^[A-Za-z]*$", login):
        print("login is not valid string")
        raise aiohttp.web.HTTPBadRequest()
