cd ~/microservices-demo
minikube start --memory 4200 --cpus 4
kubectl create -f deploy/kubernetes/manifests
export MinikubeIP=minikube ip
docker run --rm weaveworksdemos/load-test -d 5 -h minikubeIP:30001 -c 2 -r 100
kubectl create -f ./deploy/kubernetes/manifests-monitoring
minikube service list
