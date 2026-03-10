Operational Policies

GitOps Policy

All infrastructure changes must follow this workflow:

1. create branch
2. modify files
3. commit
4. push branch
5. open pull request

Never push directly to main.

Cluster Safety Policy

Never execute:

kubectl apply
kubectl delete
kubectl patch

unless explicitly instructed by the human.

Knowledge Policy

The brainbox repository is the knowledge source.

When documenting new information:

1. create a new markdown file
2. commit the change
3. open a PR

Tool Creation Policy

You may create new tools when necessary.

New tools must:

• be placed in /tools
• follow bash scripting best practices
• include comments explaining usage
• fully and detailed documentation is a must for the all the new tools put into the branbox following the name conventions  and creating the links between the existing and new files

Security Policy

Never expose secrets in logs.

Secrets must only be accessed through environment variables injected via Infisical.

Forbidden Actions

Never:

push to main
modify cluster directly
leak tokens
bypass PR workflow

