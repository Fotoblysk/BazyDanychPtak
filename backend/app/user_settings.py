from utils import auth, utils
from utils import mysql
import settings
import hashlib
from aiohttp import web
import crypt

@auth.login_required
async def change(request):
    if settings.DEBUG:
        print("Starting change")
    data = (await request.json())
    print(data)
    newlogin = data["newlogin"]
    oldlogin = data["oldlogin"]
    oldpassword = data["oldpassword"]
    newpassword = data["newpassword"]
    newemail = data["newemail"]
    utils.validate_email(newemail)
    utils.validate_login(newlogin)
    db = mysql.get_mysql_endpoint(request)

    try:
        db_data = (await mysql.cursor_exec(db, f'SELECT `password_hash`, `salt`, `idcredentials`  from `credentials` where `login` = %s;', oldlogin))
        print(str(db_data))
        if db_data[0] > 1:
            return web.json_response(data={"status": "db_corrupted"})
        db_data = db_data[1][0]
        print(str(db_data))
    except IndexError:
        if settings.DEBUG:
            print(f'No login data for {login_} in db')
        return web.json_response(data={"status": "login_invalid"})

    old_password_hash, old_salt, id_  = db_data

    if old_password_hash != hashlib.md5((oldpassword + old_salt).encode()).hexdigest():
        return web.json_response(data={"status": "bad_password"})

    new_login_db_data = (await mysql.cursor_exec(db, f'SELECT `password_hash`, `salt`, `idcredentials`  from `credentials` where `login` = %s;', newlogin))[1]
    if len(new_login_db_data) < 0:
        return web.json_response(data={"status": "db_corrupted"})

    newsalt = crypt.mksalt(crypt.METHOD_MD5)
    newpassword = data['newpassword']
    newpassword_hash = hashlib.md5((newpassword + newsalt).encode()).hexdigest()

    await mysql.cursor_exec(db,
        f"UPDATE `credentials` SET `login`=%s, `email`=%s, `password_hash`=%s, `salt`=%s WHERE `idcredentials` = '{id_}';",  newlogin, newemail, newpassword_hash, newsalt)

    return web.json_response(data={"status": "Ok"})
