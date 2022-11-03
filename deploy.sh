docker build -t lispavel/multi-client:latest -t lispavel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lispavel/multi-server:latest -t lispavel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lispavel/multi-worker:latest -t lispavel/multi-worker:$SHA -f ./worker/Dockrefile ./worker
docker push lispavel/multi-client:latest
docker push lispavel/multi-client:$SHA
docker push lispavel/multi-server:latest
docker push lispavel/multi-server:$SHA
docker push lispavel/multi-worker:latest
docker push lispavel/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lispavel/multi-client:$SHA
kubectl set image deployments/server-deployment server=lispavel/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lispavel/multi-worker:$SHA