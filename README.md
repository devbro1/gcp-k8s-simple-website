# gcp-k8s-simple-website

## Initial steps
- install [gcloud](https://cloud.google.com/sdk/docs/install)
- install [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- install [kubectl](https://kubernetes.io/docs/tasks/tools/)
- install docker: [docker desktop for windows](https://docs.docker.com/desktop/install/windows-install/)
- obtain [treats](https://www.amazon.ca/gp/aw/d/B0B4FX74HX)



## create website docker image

command to build the image and running it as a container
```
docker build -t web_todo_image -f web.Dockerfile .
```

to deploy the image as local container:
```
docker stop web_todo_container
docker rm web_todo_container
docker run --name web_todo_container -d -p 85:85 -e FLASK_ENV=development  -e FLASK_APP=app.py -e FLASK_RUN_HOST=0.0.0.0 -e FLASK_RUN_PORT=85 web_todo_image
```

for local development without using docker:
```
cd todo-website
pip3 install -r requirements.txt -t ./
flask run
```

alternatively you can use docker-compose to create everything for you:
```
docker compose -f "docker-compose.yml" up -d --build 
```

NOTE: if `DATABASE_URL` env var is not defined then image will use a local sqlite for database.


## terraform
once gcloud is installed, run `gcloud auth application-default login` to login.
you will need to create a GCS called `tf-states-devbro` manually to save all your states in. If you prefer local state then remove backend.tf.


to create all resources:
```
terraform init
terraform plan
terraform apply -auto-approve
```
this process will take a while. It is strongly suggested to use treats to distract your cat(s) to make time pass faster.

## push image over to gcp-artifact-registry
To push images to GCP Artifact Registry. use following commands:
```
docker build -t web_todo_image -f web.Dockerfile .

gcloud auth configure-docker us-east1-docker.pkg.dev

docker tag web_todo_image:latest us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest
docker push us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest
```

## Managing kubernetes
Make sure gcloud and kubectl are installed.

Commands to connect kubectl to kubernetes cluster:
```
gcloud components install gke-gcloud-auth-plugin
gcloud container clusters get-credentials gorgias-devbro-gke --region=us-east1
kubectl config view
```


commands to create all resouces:
```
kubectl apply -f postgres-primary.yml
kubectl apply -f postgres-replica.yml
kubectl apply -f frontend-website.yml
kubectl get services
kubectl get pods
```

to remove stuff in the cluster:
```
kubectl delete -f frontend-website.yml
kubectl delete -f postgres-primary.yml
kubectl delete -f postgres-replica.yml
```

NOTE: there are storages created as part of these resources. deleting and recreating resouces will not destroy these storages.

other useful commnads:
```
kubectl exec --stdin --tty postgres-replica-0 -- /bin/bash
kubectl logs POD_NAME
kubectl get secret db-credentials -o jsonpath='{.data}'
```

note: secrets values need to be base64 decoded.

## how to fully deply
step by step orders:

1. install all required programs
2. use terraform to create all resources
3. create docker image
4. push docker image to GCP:AR
5. use kubectl to create all resources