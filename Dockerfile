FROM python:3.9.0

WORKDIR /home/

RUN echo "test ku sandbox!!"

RUN git clone https://github.com/matt700395/sandbox3.git

WORKDIR /home/sandbox3/

RUN python -m pip install --upgrade pip

RUN pip install -r requirements.txt

RUN pip install gunicorn

RUN pip install mysqlclient

EXPOSE 8000
python manage.py createsuperuser --settings=myproject.settings.deploy

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=web.settings.deploy && python manage.py migrate --settings=web.settings.deploy && gunicorn web.wsgi --env DJANGO_SETTINGS_MODULE=web.settings.deploy --bind 0.0.0.0:8000"]
