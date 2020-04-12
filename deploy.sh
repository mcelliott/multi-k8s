docker build -t hellomattelliott/multi-client:latest -t hellomattelliott/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hellomattelliott/multi-server:latest -t hellomattelliott/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hellomattelliott/multi-worker:latest -t hellomattelliott/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hellomattelliott/multi-client:latest
docker push hellomattelliott/multi-server:latest
docker push hellomattelliott/multi-worker:latest

docker push hellomattelliott/multi-client:$SHA
docker push hellomattelliott/multi-server:$SHA
docker push hellomattelliott/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=hellomattelliott/multi-client$SHA
kubectl set image deployments/server-deployment server=hellomattelliott/multi-server$SHA
kubectl set image deployments/worker-deployment worker=hellomattelliott/multi-worker$SHA