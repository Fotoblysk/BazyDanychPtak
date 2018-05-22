from utils import auth, mysql
from aiohttp import web
import time
import asyncio
from contextlib import suppress
import pymysql

def setup_db(app):
    mysql_up = False
    while not mysql_up:
        with suppress(ConnectionRefusedError, pymysql.err.OperationalError):
            app.loop.run_until_complete(mysql.check_connection(app.loop))
            app.loop.run_until_complete(mysql.create_pool(app))
            mysql_up = True
    app.on_cleanup.append(mysql.close_pool(app))


def register_endpoints(app):
    app.router.add_post('/api/login', auth.login)
    app.router.add_post('/api/register', auth.register)


print("starting backend")
loop = asyncio.get_event_loop()
app = web.Application(loop=loop)

print("loading DB")
setup_db(app)

print("Setting endpoints")
register_endpoints(app)

web.run_app(app)
