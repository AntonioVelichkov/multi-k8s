docker build -t antoniovelichkov/multi-client:latest -t antoniovelichkov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t antoniovelichkov/multi-server:latest -t antoniovelichkov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t antoniovelichkov/multi-worker:latest -t antoniovelichkov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push antoniovelichkov/multi-client:latest
docker push antoniovelichkov/multi-server:latest
docker push antoniovelichkov/multi-worker:latest
docker push antoniovelichkov/multi-client:$SHA
docker push antoniovelichkov/multi-server:$SHA
docker push antoniovelichkov/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=antoniovelichkov/multi-server:$SHA
kubectl set image deployments/client-deployment client=antoniovelichkov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=antoniovelichkov/multi-worker:$SHA
