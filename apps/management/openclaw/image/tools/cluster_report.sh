#!/bin/bash

echo "=== Cluster Status ==="

kubectl get nodes

echo
echo "=== Pods not running ==="

kubectl get pods -A | grep -v Running || true

echo
echo "=== Recent events ==="

kubectl get events -A --sort-by=.metadata.creationTimestamp | tail -50
