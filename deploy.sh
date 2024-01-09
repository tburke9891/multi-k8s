# build the images
###### new ######
docker build -t thomasburke9891/multi-client:latest -f ./client/Dockerfile ./client
docker build -t thomasburke9891/multi-server:latest -f ./server/Dockerfile ./server
docker build -t thomasburke9891/multi-worker:latest -f ./worker/Dockerfile ./worker

# ###### old ######
# docker build -t thomasburke9891/multi-client:latest -t thomasburke9891/multi-client:$SHA -f ./client/Dockerfile ./client
# docker build -t thomasburke9891/multi-server:latest -t thomasburke9891/multi-server:$SHA -f ./server/Dockerfile ./server
# docker build -t thomasburke9891/multi-worker:latest -t thomasburke9891/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push images to dockerhub
###### new ######
docker push thomasburke9891/multi-client:latest
docker push thomasburke9891/multi-server:latest
docker push thomasburke9891/multi-worker:latest

# ###### old ######
# docker push thomasburke9891/multi-client:latest
# docker push thomasburke9891/multi-server:latest
# docker push thomasburke9891/multi-worker:latest
# docker push thomasburke9891/multi-client:$SHA
# docker push thomasburke9891/multi-server:$SHA
# docker push thomasburke9891/multi-worker:$SHA

# apply k8s directory config
kubectl apply -f k8s

###### new ######
# send the latest image to hub.docker.com
kubectl set image deployments/server-deployment server=thomasburke9891/multi-server
kubectl set image deployments/client-deployment client=thomasburke9891/multi-client
kubectl set image deployments/worker-deployment worker=thomasburke9891/multi-worker

# force fresh pull of images
kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/client-deployment
kubectl rollout restart deployment/worker-deployment

# ###### old ######
# kubectl set image deployments/server-deployment server=thomasburke9891/multi-server:$SHA
# kubectl set image deployments/client-deployment client=thomasburke9891/multi-client:$SHA
# kubectl set image deployments/worker-deployment worker=thomasburke9891/multi-worker:$SHA