from auth import need_auth
from aiohttp import web


@need_auth
async def getMap(request):
    data = (await request.json())
    return web.json_response(data={"status": "test"})
