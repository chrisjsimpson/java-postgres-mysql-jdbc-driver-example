 sudo microk8s.kubectl delete deployment postgres
 sudo microk8s.kubectl delete deployment myjavaapp
 sudo microk8s.kubectl delete pvc postgres-volume-claim
 sudo microk8s.kubectl delete pvc postgres
 sudo microk8s.kubectl delete service postgres-service
 sudo microk8s.kubectl delete service myjavaapp-service
 sudo microk8s.kubectl delete secret postgres-credentials
 sudo microk8s.kubectl get pvc
 sudo microk8s.kubectl get pv
