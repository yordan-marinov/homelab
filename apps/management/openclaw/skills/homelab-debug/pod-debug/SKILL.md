---
name: pod-debug
description: Debug failing Kubernetes pods.
metadata:
  {
    "openclaw":
      {
        "emoji": "🐞",
        "requires": { "bins": ["kubectl"] }
      }
  }
---

# Pod Debugging

Steps:

List failing pods:

kubectl get pods -A | grep -v Running

Inspect pod:

kubectl describe pod <pod> -n <namespace>

Check logs:

kubectl logs <pod> -n <namespace>

