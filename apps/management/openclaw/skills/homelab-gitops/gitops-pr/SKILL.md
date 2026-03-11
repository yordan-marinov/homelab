---
name: gitops-pr
description: Create GitOps change and open PR.
metadata:
  {
    "openclaw":
      {
        "emoji": "🌿",
        "requires": { "bins": ["git"] }
      }
  }
---

# GitOps Change Workflow

Never modify the cluster directly.

Workflow:

1. create branch

/tools/repo_branch.sh fix/<issue>

2. modify files

3. commit

/tools/repo_commit.sh "fix: description"

4. open PR

/tools/repo_pr.sh

