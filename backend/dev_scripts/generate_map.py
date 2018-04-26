import sys
sys.path.append("..")
from app import db
import json
from elasticsearch import Elasticsearch
from redis import Redis
import time


#time.sleep(100)
es = Elasticsearch("localhost", http_auth=('elastic', 'changeme'))

for i in range(100):
    for j in range(100):
        userData = json.dumps({"owner": "user" + str(i) + "_" + str(j),
                               "score": str(i) + str(j)})
        es.index(index="map", doc_type="base", id=str(i) + "_" + str(j), body=userData)
