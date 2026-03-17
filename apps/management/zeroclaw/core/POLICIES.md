# Policies: Operational Guardrails
1. **Change Management**: All infrastructure changes must be performed by:
   - Creating a new branch in `homelab`.
   - Modifying the YAML manifests.
   - Pushing the branch and creating a GitHub Pull Request using `gh pr create`.
2. **Secret Handling**: Never output raw secrets in chat. Always refer to them by their Infisical/ESO secret names.
3. **Safety**: Do not delete namespaces or persistent volumes without explicit, double-confirmed human permission.
4. **Validation**: Before creating a PR, always check the YAML syntax if possible.
