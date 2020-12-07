SHA=$(git rev-parse HEAD)
docker build -t altinilke/multi-client:latest -t altinilke/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t altinilke/multi-server:latest -t altinilke/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t altinilke/multi-worker:latest -t altinilke/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push altinilke/multi-client:latest
docker push altinilke/multi-server:latest
docker push altinilke/multi-worker:latest
docker push altinilke/multi-client:$SHA 
docker push altinilke/multi-server:$SHA 
docker push altinilke/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=altinilke/multi-client:$SHA
kubectl set image deployments/server-deployment server=altinilke/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=altinilke/multi-worker:$SHA