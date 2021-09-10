docker build -t ajith2234/multi-client:latest -t ajith2234/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajith2234/multi-server:latest -t ajith2234/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajith2234/multi-worker:latest -t ajith2234/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ajith2234/multi-client:latest
docker push ajith2234/multi-server:latest
docker push ajith2234/multi-worker:latest

docker push ajith2234/multi-client:$SHA
docker push ajith2234/multi-server:$SHA
docker push ajith2234/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajith2234/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajith2234/multi-client:$SHA
kubectl set image deployments/worker/deployment worker=ajith2234/multi-worker:$SHA

