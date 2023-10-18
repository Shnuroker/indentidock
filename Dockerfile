FROM python:3.8

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN apt install gcc
RUN pip install Flask==3.0.0 uWSGI==2.0.22 requests==2.31.0 redis==5.0.1
WORKDIR /app
COPY app /app
COPY cmd.sh /
RUN chmod a+x /cmd.sh

EXPOSE 9090 9191
USER uwsgi

CMD ["/cmd.sh"]

#CMD ["uwsgi", "--http", "0.0.0.0:9090", "--wsgi-file", "/app/identidock.py", "--callable", "app", "--stats", "0.0.0.0:9191"]
