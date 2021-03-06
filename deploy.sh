docker build -t ovidiuvlad09/multi-client-k8s:latest -t ovidiuvlad09/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ovidiuvlad09/multi-server-k8s-pgfix:latest -t ovidiuvlad09/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t ovidiuvlad09/multi-worker-k8s:latest -t ovidiuvlad09/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ovidiuvlad09/multi-client-k8s:latest
docker push ovidiuvlad09/multi-server-k8s-pgfix:latest
docker push ovidiuvlad09/multi-worker-k8s:latest

docker push ovidiuvlad09/multi-client-k8s:$SHA
docker push ovidiuvlad09/multi-server-k8s-pgfix:$SHA
docker push ovidiuvlad09/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ovidiuvlad09/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=ovidiuvlad09/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ovidiuvlad09/multi-worker-k8s:$SHA
