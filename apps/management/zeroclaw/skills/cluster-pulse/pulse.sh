#!/bin/bash
echo "=== NODE STATUS ==="
kubectl get nodes -o custom-columns=NAME:.metadata.name,STATUS:.status.conditions[?(@.type==\"Ready\")].status

echo -e "\n=== UNHEALTHY PODS ==="
# Get pods that are not Running or Succeeded
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded

echo -e "\n=== RECENT WARNING EVENTS ==="
kubectl get events -A --field-selector type=Warning --sort-by='.lastTimestamp' | tail -n 5
