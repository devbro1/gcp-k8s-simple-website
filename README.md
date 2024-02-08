# gcp-k8s-simple-website

## Initial steps
- install [gcloud](https://cloud.google.com/sdk/docs/install)
- install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/)
- install docker: [docker desktop for windows](https://docs.docker.com/desktop/install/windows-install/)



# create website docker image

command to build the image
```
docker build -t web_image -f web.Dockerfile .
```

for local development you need to install packages:
```
pip3 install -r requirements.txt -t ./
```

environment variables to set:
```
export DATABASE_URL=postgresql+psycopg2://user:password@hostname/database_name
export DATABASE_URL=postgresql://user:password@hostname/database_name
export FLASK_APP=app.py
export FLASK_ENV=development
```