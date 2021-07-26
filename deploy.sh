docker build -t kringel/multi-client:latest -t kringel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kringel/multi-server:latest -t kringel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kringel/multi-worker:latest -t kringel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kringel/multi-client:latest
docker push kringel/multi-server:latest
docker push kringel/multi-worker:latest

docker push kringel/multi-client:$SHA
docker push kringel/multi-server:$SHA
docker push kringel/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kringel/multi-client:$SHA
kubectl set image deployments/server-deployment server=kringel/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kringel/multi-worker:$SHA