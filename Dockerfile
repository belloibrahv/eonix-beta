FROM python:3.9-alpine3.13

LABEL org.opencontainers.image.authors="belloibrahim.vercel.app"

ENV PYTHONUNBUFFERED 1


COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./api /api

WORKDIR /api
EXPOSE 8000

ARG DEV=false

RUN python -m venv /.venv && \
    /.venv/bin/pip install --upgrade pip && \
    /.venv/bin/pip install -r /tmp/requirements.txt && \
    if [ ${DEV} == true ];  \
        then /.venv/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
      --disabled-password \
      --no-create-home \
      django-user

ENV PATH='/.venv/bin:$PATH'

USER django-user
