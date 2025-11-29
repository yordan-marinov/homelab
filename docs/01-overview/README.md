# 01-Overview: Project Vision, Goals, and High-Level Architecture

This section provides a concise, high-level overview of the Home Lab Project, outlining its overarching vision, specific goals, and the fundamental architectural choices that drive its design and implementation. It serves as an executive summary for anyone seeking to understand the project's scope and ambition.

---

## **1. Project Vision**

The **Home Lab Project** envisions the creation of a personal, enterprise-grade, cloud-native learning platform. This platform is meticulously designed to mimic the complexity and best practices found in professional IT environments, serving as both a robust learning sandbox and a capable personal data center. Its core purpose is to cultivate deep, hands-on expertise across modern IT infrastructure, DevOps, and cloud-native domains.

## **2. Overarching Goals**

The project aims to:

* **Elevate Professional Skills:** Master Kubernetes, distributed storage, advanced networking, and security concepts through practical application.
* **Embody Cloud-Native Principles:** Design and implement a Kubernetes cluster on bare-metal, leveraging immutability and API-driven management.
* **Achieve High Availability (HA) & Resilience:** Ensure the continuous operation of critical services and data, tolerating component failures within the lab.
* **Optimize Resources:** Make strategic use of cost-effective, energy-efficient, and robust refurbished hardware.
* **Build a Personal Cloud:** Host self-managed media streaming, file sharing, personal websites, and provide secure data backups.
* **Promote Operational Excellence:** Implement monitoring, logging, and automated processes that reflect real-world SRE and DevOps practices, including centralized cluster management.
* **Document Knowledge:** Maintain comprehensive, version-controlled documentation of all architectural decisions, configurations, and lessons learned.

## **3. High-Level Architecture Summary**

The lab's foundation consists of:

* A **dedicated OPNsense Firewall PC** as the central security and routing gateway.
* A **dedicated Management/Utility Host** running Proxmox VE for centralized cluster management (Omni), monitoring (Prometheus/Grafana), and logging (Loki/Fluentd).
* A **multi-node Kubernetes cluster** (3 Masters, 3 Workers) running Talos Linux.
* A **hybrid storage strategy** combining Ceph (on Kubernetes) with a dedicated TrueNAS server.
* Robust **VLAN-based network segmentation** across managed switches.
* Repurposed consumer routers acting as **Wi-Fi Access Points**.

For a detailed visual representation, refer to the [[10-architecture/high_level_view.md|High-Level Architectural View]].
For specific project goals, see [[01-overview/goals.md]].
For a detailed breakdown of core architectural principles, see [[01-overview/architecture_overview.md]].
