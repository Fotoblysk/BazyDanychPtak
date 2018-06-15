import settings
import datetime
from aiohttp import web
from utils import mysql

async def get_orders(request):
    try:
        db = mysql.get_mysql_endpoint(request)
        db_data = (await mysql.cursor_exec(db, 'SELECT *  from `orders_prev`;'))[1]
        print(db_data)
        response = {}
        response["orders"] = [{"id": i[0], "table": i[4], "order_date": str(i[2]), "state": i[3],
            "finish_date": str(i[5]), "paid_money": str(i[7] if i[7] is not None else "0"), "bill_money": str(i[6] if i[6] is not None else "0")} for i in db_data]
        print(response)
        return web.json_response(data=response)
    except IndexError:
        if settings.DEBUG:
            print(f'No orders')
        return web.json_response(data={"status": "no_orders"})

async def order_details(request):
    try:
        db = mysql.get_mysql_endpoint(request)
        db_data = (await mysql.cursor_exec(db, 'SELECT *  from `orders`;'))[1]
        print(db_data)
        response = {}
        response["details"] = {"id": db_data[0][0], "table": db_data[0][4], "state":  db_data[0][3]}
        print(response)
        return web.json_response(data=response)
    except IndexError:
        if settings.DEBUG:
            print(f'No orders')
        return web.json_response(data={"status": "no_orders"})

async def add_order(request):
    db = mysql.get_mysql_endpoint(request)
    data = (await request.json())
    print(data)
    newbill = data["newbill"]
    newtable = data["newtable"]
    newstate = data["newstate"]
    newcomment = ""
    date = datetime.datetime.now().strftime(mysql.MYSQL_TIMEDELTA_FORMAT)

    resp = await mysql.cursor_exec(db,
        f"INSERT INTO `main`.`orders` (`comments`, `datetime1`, `status`, `table`) VALUES (%s, %s, %s, %s);", newcomment, date, newstate, newtable)
    print("test")
    print(str(resp))
    print("test1")
    print(await mysql.cursor_exec(db, f"SELECT * FROM `orders` ORDER BY `idorders` DESC LIMIT 0, 1;"))
    id__ = (await mysql.cursor_exec(db, f"SELECT * FROM `orders` ORDER BY `idorders` DESC LIMIT 0, 1;"))[1][0][0]
    print("test2")
    print(str(id__))
    print(str(newbill))
    await mysql.cursor_exec(db,
        f"INSERT INTO `main`.`bills` (`money`, `orders_idorders`) VALUES (%s, %s);", newbill, id__)

    return web.json_response(data={"status": "no_orders"})
