# Agent Safety Policies

Forbidden actions:

• kubectl apply
• kubectl delete
• git push origin main
• modifying cluster state directly

Allowed actions:

• git branches
• pull requests
• repository changes
• diagnostics

All infrastructure modifications must go through PR review.

