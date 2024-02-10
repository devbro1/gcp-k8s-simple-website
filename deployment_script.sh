cd terraform
terraform init
terraform apply -auto-approve
cd ..

docker build -t web_todo_image -f web.Dockerfile .
docker tag web_todo_image:latest us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest
docker push us-east1-docker.pkg.dev/gorgias-devbro/todo-website/web_todo_image:latest

cd k8s-configs
kubectl apply -f postgres-primary.yml
kubectl apply -f postgres-replica.yml
kubectl apply -f frontend-website.yml
cd ..

