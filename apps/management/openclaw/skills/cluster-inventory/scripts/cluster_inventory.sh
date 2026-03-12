#!/bin/bash

echo "===== CLUSTER INVENTORY ====="

echo
echo "NODES"
kubectl get nodes -o wide

echo
echo "NAMESPACES"
kubectl get ns

echo
echo "PODS"
kubectl get pods -A

echo
echo "SERVICES"
kubectl get svc -A

echo
echo "INGRESS"
kubectl get ingress -A 2>/dev/null || echo "No ingress permissions"

echo
echo "STORAGE"
kubectl get pvc -A 2>/dev/null || echo "No pvc permissions"
