import auth
import userActions
from aiohttp import web
import time


print("starting backend")
print("loading DB")
# ignore 400 cause by IndexAlreadyExistsException when creating an index

app = web.Application()
app.router.add_post('/api/login', auth.login)
app.router.add_post('/api/register', auth.register)
app.router.add_post('/api/smallmap', userActions.getMap)

web.run_app(app)
