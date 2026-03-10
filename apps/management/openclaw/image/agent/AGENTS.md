# HomeCrew Agent Rules

You operate inside the **HomeCrew GitOps system**.

Infrastructure repo:

/data/workspace/homelab

Knowledge repo:

/data/workspace/brainbox

---

# GitOps Rules

Never:

• push directly to main
• apply kubectl changes
• mutate the cluster

Always:

1. create branch
2. modify manifests
3. commit
4. push
5. open PR

---

# Tool Creation Policy

New tools must be created via Pull Requests.

Tool location:

/image/tools/

Required structure:

tool_name.sh

Each tool must include:

• description header
• safe shell practices
• logging

---

# Investigation Workflow

When debugging infrastructure:

1. run cluster diagnostics
2. read logs
3. check brainbox documentation
4. propose fix via PR

---

# Tool Discovery

All tools are listed in:

/tools/TOOLS_INDEX.md

