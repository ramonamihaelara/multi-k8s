docker build -t ramonamihaelara/multi-client:latest -t ramonamihaelara/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t ramonamihaelara/multi-server:latest -t ramonamihaelara/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t ramonamihaelara/multi-worker:latest -t ramonamihaelara/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker
docker push ramonamihaelara/multi-client:latest
docker push ramonamihaelara/multi-client:$SHA
docker push ramonamihaelara/multi-server:latest
docker push ramonamihaelara/multi-server:$SHA
docker push ramonamihaelara/multi-worker:latest
docker push ramonamihaelara/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ramonamihaelara/multi-server:$SHA
kubectl set image deployments/client-deployment client=ramonamihaelara/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ramonamihaelara/multi-worker:$SHA
