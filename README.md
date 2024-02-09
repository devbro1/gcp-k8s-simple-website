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

## terraform
once gcloud is installed, run `gcloud auth application-default login` to login.
after that you can do:
```
terraform init
terraform plan
terraform apply -auto-approve
```

## push image over to gcp-artifact-registry

```
gcloud auth configure-docker us-east1-docker.pkg.dev

docker tag web_todo_image:latest us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest
docker push us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest
```

## k8s
make sure gcloud is installed then login
make sure kubectl is installed

you will need these commands:
```
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials gorgias-devbro-gke --region=us-east1
kubectl config view
```

to create your stuff in the cluster:
```
kubectl apply -f frontend-website.yml
kubectl get services
kubectl get pods
```

to remove stuff in the cluster:
```
kubectl delete -f frontend-website.yml
```