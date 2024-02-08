FROM python:3.12.2-slim

WORKDIR /usr/src/app

COPY ./todo-website/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./todo-website ./
CMD [ "python", "./app.py" ]
