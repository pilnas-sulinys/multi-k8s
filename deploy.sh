docker build -t sulinys/multi-client:latest -t sulinys/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sulinys/multi-server:latest -t sulinys/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sulinys/multi-worker:latest -t sulinys/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push sulinys/multi-client:latest 
docker push sulinys/multi-server:latest
docker push sulinys/multi-worker:latest
docker push sulinys/multi-client:$GIT_SHA 
docker push sulinys/multi-server:$GIT_SHA
docker push sulinys/multi-worker:$GIT_SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=sulinys/multi-server:$GIT_SHA
kubectl set image deployments/client-deployments client=sulinys/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployments worker=sulinys/multi-worker:$GIT_SHA