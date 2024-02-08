# gcp-k8s-simple-website

## Initial steps
- install [gcloud](https://cloud.google.com/sdk/docs/install)
- install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/)
- install docker: [docker desktop for windows](https://docs.docker.com/desktop/install/windows-install/)



# create website docker image

command to build the image and running it as a container
```
docker build -t web_todo_image -f web.Dockerfile .
docker stop web_todo_container
docker rm web_todo_container
docker run --name web_todo_container -d -p 85:85 -e FLASK_ENV=development  -e FLASK_APP=app.py -e FLASK_RUN_HOST=0.0.0.0 -e FLASK_RUN_PORT=85 web_todo_image
```

for local development you need to install packages:
```
pip3 install -r requirements.txt -t ./
```

NOTE in dev env, it uses sqlite it can be changed to postgresql with `DATABASE_URL` env var

environment variables to set:
```
export DATABASE_URL=postgresql://user:password@hostname/database_name
export FLASK_APP=app.py
export FLASK_ENV=development
```
