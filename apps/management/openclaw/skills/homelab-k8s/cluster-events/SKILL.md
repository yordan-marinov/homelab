---
name: cluster-events
description: Inspect Kubernetes events for failures.
metadata:
  {
    "openclaw":
      {
        "emoji": "📜",
        "requires": { "bins": ["kubectl"] }
      }
  }
---

# Cluster Events

Use this skill to investigate failures.

Commands:

kubectl get events -A --sort-by=.metadata.creationTimestamp

