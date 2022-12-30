docker build -t lyoshas/multi-client:latest -t lyoshas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lyoshas/multi-server:latest -t lyoshas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lyoshas/multi-worker:latest -t lyoshas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lyoshas/multi-client:latest
docker push lyoshas/multi-server:latest
docker push lyoshas/multi-worker:latest

docker push lyoshas/multi-client:$SHA
docker push lyoshas/multi-server:$SHA
docker push lyoshas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lyoshas/multi-server:$SHA
kubectl set image deployments/client-deployment client=lyoshas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lyoshas/multi-worker:$SHA