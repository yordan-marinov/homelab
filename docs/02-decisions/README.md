# 02-Decisions: Architectural Choices and Justifications

This section details the critical decisions made during the planning and initial setup phases of the Home Lab Project. Each document provides its rationale, considering factors such as cost, performance, scalability, security, and learning objectives. Understanding these choices is key to comprehending the overall [[01-overview/architecture_overview.md|architecture]].

---

## 1. [[02-decisions/hardware_selection.md|Hardware Selection Justification]]

Choosing specific hardware models for each role.

## 2. [[02-decisions/software_os_choices.md|Software & OS Choices]]

Selecting the operating systems and core software components.

## 3. [[02-decisions/network_topology_decisions.md|Network Topology Decisions]]

Designing the physical and logical network structure.

## 4. [[02-decisions/storage_strategy.md|Storage Strategy (Hybrid: Ceph on K8s + TrueNAS)]]

Deciding on the hybrid approach for data storage.

## 5. [[02-decisions/management_plane_design.md|Management Plane Design]]

Rationale for the dedicated Proxmox host to manage and observe the cluster.

## 6. [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]

Acknowledging the practical compromises made to balance ideal scenarios with real-world constraints.

---

## Related Links

- [[docs/index.md|Homelab Project Documentation Index]]
- [[01-overview/architecture_overview.md|High-Level Architecture Overview]]
