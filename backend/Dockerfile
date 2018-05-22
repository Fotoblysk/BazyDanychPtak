FROM python:latest
ADD requirements.txt /
RUN pip3 install -r /requirements.txt
ENTRYPOINT python3 -u /app/run.py
