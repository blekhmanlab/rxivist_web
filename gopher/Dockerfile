FROM python:slim
MAINTAINER Richard Abdill

COPY requirements.txt /
RUN pip install -r /requirements.txt

RUN apt-get update
RUN apt install -y curl

ADD . /app
WORKDIR /app

HEALTHCHECK --start-period=30s --interval=30s --timeout=20s CMD bash /app/test.sh || exit 1

CMD ["python", "main.py"]
