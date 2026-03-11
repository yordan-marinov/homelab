---
name: cluster-health
description: Inspect Kubernetes cluster health and node status.
metadata:
  {
    "openclaw":
      {
        "emoji": "☸️",
        "requires": { "bins": ["kubectl"] }
      }
  }
---

# Cluster Health

Use this skill when the user asks about cluster health.

Commands:

Check nodes:

kubectl get nodes -o wide

Check system pods:

kubectl get pods -n kube-system

Check cluster info:

kubectl cluster-info

For full report:

/tools/cluster_report.sh

