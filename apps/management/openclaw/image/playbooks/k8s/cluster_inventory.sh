#!/bin/bash

echo "==== NODES ===="
kubectl get nodes -o wide

echo "==== NAMESPACES ===="
kubectl get ns

echo "==== DEPLOYMENTS ===="
kubectl get deploy -A

echo "==== SERVICES ===="
kubectl get svc -A

echo "==== INGRESS ===="
kubectl get ingress -A

echo "==== STORAGE ===="
kubectl get pvc -A
