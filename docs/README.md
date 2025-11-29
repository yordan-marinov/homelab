# 🏡 Homelab – Enterprise-Grade Learning & Showcase

This **HomeLab** project is a comprehensive, hands-on, personal learning and showcase environment for **enterprise-grade IT architecture, DevOps, SRE, and cloud-native practices**. It functions as both a personal sandbox and a professional portfolio, demonstrating the ability to design, deploy, maintain, and operate complex infrastructure and software systems following **industry best practices**.

Every decision, deployment, and configuration within this lab reflects real-world, production-inspired workflows, emphasizing structured, process-driven thinking.

---

## 🌐 Vision & Core Objectives

The primary goal of this homelab is to **bridge the gap between learning and operational excellence** by:

- **Designing End-to-End Infrastructure:** From bare-metal hardware and advanced networking to container orchestration and hybrid storage.
- **Mastering Cloud-Native:** Deep practical experience with Kubernetes, CI/CD, and GitOps for modern application delivery.
- **Security & Resilience:** Implementing robust network security, high availability, and disaster recovery strategies.
- **Operational Proficiency:** Building expertise in DevOps, SRE, observability (monitoring, logging), and centralized cluster management.
- **Knowledge Management:** Documenting the entire learning journey, decisions, and lessons learned (see `docs/` for details).

---

## 🧱 Key Architectural Principles

The design of this homelab is founded on principles common in enterprise environments:

1. **Bare-Metal Kubernetes & Immutable Infrastructure:** Direct hardware interaction, reduced overhead, and consistent, easily replaceable systems (e.g., Talos Linux for Kubernetes hosts).
2. **Dedicated OPNsense Firewall:** A central security gateway, eliminating NAT complexities and enabling granular control across all network segments.
3. **Multi-Interface Firewall & VLAN Segmentation:** Physical separation of major network segments, complemented by VLANs for logical isolation of different trust zones (e.g., Kubernetes, Management, IoT, NAS, Home Wi-Fi).
4. **Hybrid & Resilient Storage:** Combining Ceph (for Kubernetes-native operational data) with a dedicated ZFS-based NAS (for bulk media archives), both designed for high availability and data integrity.
5. **Cloud-Native Orchestration:** Kubernetes (multi-node, highly available) as the core platform for automated application deployment, scaling, and management.
6. **Centralized Management Plane:** A dedicated Proxmox host manages critical infrastructure components *outside* the main Kubernetes cluster (e.g., Omni for K8s lifecycle, Prometheus/Grafana for monitoring, Loki for logging).
7. **Observability & Automation:** Integrated tools for comprehensive monitoring, logging, and automated workflows (CI/CD, GitOps) to ensure reliability and efficiency.
8. **Resource Optimization:** Strategic use of cost-effective, energy-efficient hardware, maximizing utility and minimizing operational overhead.
9. **Stateful Apps on K8s:** Leveraging Kubernetes' native HA capabilities for stateful workloads (databases, message brokers, media servers).

---

## 🔑 Learning & Skill Development Focus

This project is a vehicle for developing and showcasing advanced skills in:

- **DevOps & SRE:** CI/CD, Automation, Infrastructure as Code (IaC), GitOps, Observability.
- **Cloud-Native:** Kubernetes Architecture, Containerization, Microservices, Distributed Storage (Ceph).
- **Networking & Security:** Firewalls, VLANs, VPNs, Zero-Trust Concepts, Intrusion Detection.
- **Storage Systems:** ZFS, TrueNAS, Distributed Storage (Ceph), Replication, Snapshots, Backup Strategies.
- **Virtualization:** Proxmox VE, LXC container management.
- **Infrastructure Management:** Bare-metal operations, server administration, centralized cluster lifecycle (Omni).
- **Troubleshooting:** Systematic problem-solving across hardware, firmware, network, and software layers.

---

## **6. Project Structure**

The project documentation is organized for clarity and modularity:

```
homelab/
├── docs/ # Comprehensive documentation: all details, configurations, decisions, and learning notes
│ └── index.md # Main entry point and topic map for detailed docs
│ └── README.md # Detailed overview of the project, goals, and architecture (more verbose than this repo README)
│ └── 01-overview/ # Project vision, goals, high-level architecture
│ └── 02-decisions/ # Justifications for hardware, software, and design choices
│ └── 03-infrastructure/ # Detailed hardware specifications for each component
│ └── 04-platform/ # Kubernetes platform specifics (distro, HA design)
│ └── 05-software/ # Software stack beyond core OS/K8s
│ └── 06-network/ # Full network topology, IP scheme, OPNsense/Switch config
│ └── 07-storage/ # Ceph and NAS storage design and implementation
│ └── 08-operations/ # Monitoring, logging, backup, and maintenance procedures
│ └── 09-docs/ # External references, templates
│ └── 10-architecture/ # Architectural diagrams and design principles
├── infra/ # Infrastructure as Code (IaC) files, deployment scripts, automation
├── README.md # This main repository overview (high-level, conceptual)
└── .devcontainer/ # Dev Container setup (optional)
```

---

## **7. Outcomes & Showcase**

Through this homelab, I aim to:

- Demonstrate ability to **design and maintain enterprise-grade infrastructure** from bare metal to application.
- Practice **security-focused operations** in a realistic environment with advanced tools.
- Create **reusable templates and automation** for future projects, embodying IaC and GitOps.
- Maintain **hands-on expertise with current industry tools** (Kubernetes, OPNsense, TrueNAS, Proxmox, Omni, Prometheus, Grafana, Talos Linux, Ceph).
- Showcase **seniority in planning, architecture, and operational management**, proving structured, process-driven thinking.

---

## **8. Philosophy**

> "Build like you run production, learn like it’s your sandbox. Document everything."
