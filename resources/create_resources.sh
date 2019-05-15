#! /bin/sh
k3s kubectl delete secret gce-service-account walklog-env
k3s kubectl delete configmap nginx-conf nginx-conf-d 
k3s kubectl create configmap --save-config nginx-conf --from-file nginx
k3s kubectl create configmap --save-config nginx-conf-d --from-file conf.d
k3s kubectl create secret generic --save-config walklog-env --from-env-file=.env
k3s kubectl create secret generic --save-config gce-service-account --from-file asharpminor-63e8ef7fa8de.json
