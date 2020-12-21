docker build -t sherrajput/multi-client:latest -t sherrajput/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t sherrajput/multi-server:latest -t sherrajput/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sherrajput/multi-worker:latest -t sherrajput/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sherrajput/multi-client:latest
docker push sherrajput/multi-server:latest
docker push sherrajput/multi-worker:latest

docker push sherrajput/multi-client:$SHA
docker push sherrajput/multi-server:$SHA
docker push sherrajput/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=sherrajput/multi-server:$SHA
kubectl set image deployments/client-deployment client=sherrajput/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sherrajput/multi-worker:$SHA