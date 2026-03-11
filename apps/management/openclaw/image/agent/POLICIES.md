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

## Skill Usage Policy

When performing infrastructure tasks you MUST prioritize using available skills before executing raw shell commands.

Always check /app/skills first.

If a relevant skill exists:
1. Use the skill
2. Follow the playbook referenced inside the skill
3. Do not improvise commands unless the skill fails

