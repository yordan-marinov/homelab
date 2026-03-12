---
name: cluster_inventory
description: Generate a complete inventory of the Kubernetes cluster including nodes, pods, services and storage.
---

# Cluster Inventory Skill

Use this skill when the user asks about:

- cluster health
- infrastructure overview
- running services
- nodes
- pods
- storage

Examples:

- "cluster health"
- "what is running on the cluster"
- "show cluster inventory"

## Workflow

Run the cluster inventory script:

scripts/cluster_inventory.sh

Return the output to the user in a summarized format.

