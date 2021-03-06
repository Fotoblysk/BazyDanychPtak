import aiomysql
import asyncio
import datetime


db_name = 'db'

async def cursor_exec(pool, query, *args):
    async with pool.acquire() as conn:
        async with conn.cursor() as curr:
            print("args:")
            print(str([i for i in args]))
            if args == ():
                print("ooo")
                init_response = await curr.execute(query)
            else:
                init_response = await curr.execute(query, args)
            await conn.commit()

            return (init_response, await curr.fetchall())



async def check_connection(loop):
    async with aiomysql.connect(host='mysql', port=3306,
                           user='root', password='1234',
                           db='mysql', loop=loop) as conn:
        async with conn.cursor() as cur:
            await cur.execute("SELECT 42;")
            value = await cur.fetchone()
            print("Connected to db")
            if value == (42,):
                print("Connection valid")


async def create_pool(app):
    app[db_name] = await aiomysql.create_pool(host='mysql', port=3306,
                                              user='root', password='1234',
                                              db='main', loop=app.loop)
    print("Loaded: ")
    print(str(await cursor_exec(app[db_name], 'SHOW TABLES from main;')))

def get_mysql_endpoint(req):
    return req.app[db_name]

async def close_pool(app):
    print("Closing connection pool")
    app[db_name].close()
    await app[db_name].wait_closed()

MYSQL_TIMEDELTA_FORMAT = "%y-%m-%d %H:%M:%S"

