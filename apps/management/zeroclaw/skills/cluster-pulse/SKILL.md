# Skill: Cluster Pulse
**Description**: Performs a comprehensive health check of the Kubernetes cluster.
**Trigger**: Use this when the user asks "how is the cluster doing?", "check health", or "is anything broken?".

## Capabilities
- Checks if any nodes are in `NotReady` state.
- Identifies pods that are NOT `Running` or `Succeeded`.
- Retrieves the 5 most recent `Warning` events from the cluster.

## Usage
Execute the script `./pulse.sh`.
Interpret the output and summarize the health of the lab.
