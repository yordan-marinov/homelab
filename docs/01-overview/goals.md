# Project Goals & Learning Objectives

This document elaborates on the specific goals and learning objectives driving the [[Home Lab Project]]. These goals are designed to provide a clear roadmap for skill development and project outcomes.

## 1. Overarching Goal

To build a highly available (HA) and resilient cloud-native home lab that closely mimics enterprise environments, serving as a hands-on platform for continuous learning and professional development.

## 2. Learning Goals

*   **Kubernetes Mastery:** Deep understanding of cluster deployment, management, high availability, networking, and storage, including advanced concepts like [[Talos Linux]] and API-driven management.
*   **Networking Excellence:** Practical application of [[VLANs]], advanced firewall rules, routing, and [[llnotes/VPN|VPNs]] with [[05-software/opnsense|OPNsense]].
*   **Distributed Storage:** Hands-on experience with [[llnotes/Ceph|Ceph]] via [[Rook]], including deployment, scaling, and [[llnotes/Availability|data resilience]].
*   **ZFS Administration:** Proficiency in [[llnotes/ZFS|ZFS]] for both [[05-software/opnsense|OPNsense]] and [[TrueNAS SCALE|TrueNAS]].
*   **DevOps & SRE Skills:** Learning [[llnotes/DevOps Methodology|DevOps]] principles, [[Continuous Integration (CI)]]/[[Continuous Delivery (CD)]], [[llnotes/GitOps|GitOps]], [[05-software/monitoring|monitoring]] ([[llnotes/Prometheus|Prometheus]]/[[llnotes/Grafana|Grafana]]), [[05-software/logging|logging]] ([[llnotes/Loki|Loki]]/[[llnotes/Fluentd|Fluentd]]), and operational best practices.
*   **Architectural Thinking:** Developing the ability to make informed trade-offs, design for [[llnotes/Scalability|scalability]], [[llnotes/Availability|resilience]], and [[Network Security|security]].
*   **Automation:** Exploring [[Infrastructure as Code (IaC)]] principles and scripting.

## 3. Functional Goals

*   Host professional development projects and demo applications within [[Kubernetes Namespaces|isolated Kubernetes namespaces]].
*   Run [[05-software/applications#Media Servers (Plex/Jellyfin)|personal media streaming services]] (e.g., Plex/Jellyfin).
*   Provide a secure, highly available [[File Sharing|personal file and media share]] (e.g., [[Nextcloud]]/Immich).
*   Host personal websites and scheduled applications.
*   Serve as a robust [[08-operations/backup_recovery|backup target]] for critical data and personal documents.

## 4. Non-Functional Requirements

*   **Cost-Effectiveness:** Utilize [[Refurbished Business Hardware|refurbished hardware]] where possible to maximize value.
*   **Energy Efficiency:** Prioritize low-power components and configurations for 24/7 operation.
*   **Quiet Operation:** Minimize fan noise in the home environment.
*   **Scalability:** Design for incremental expansion of compute and storage resources.
*   **Enterprise Mimicry:** Align design and operational practices with industry standards.
*   **Documentation:** Maintain comprehensive and interconnected documentation for reproducibility and knowledge transfer.

## 5. Learning & Skill Development Focus (Summary)

This project is a vehicle for developing and showcasing advanced skills in:

*   **DevOps & SRE:** CI/CD, Automation, Infrastructure as Code (IaC), GitOps, Observability.
*   **Cloud-Native:** Kubernetes Architecture, Containerization, Microservices, Service Mesh.
*   **Networking & Security:** Firewalls, VLANs, VPNs, Zero-Trust Concepts, Intrusion Detection.
*   **Storage Systems:** ZFS, Distributed Storage (Ceph), Replication, Snapshots, Backup Strategies.
*   **Infrastructure Management:** Bare-metal operations, server administration, troubleshooting across layers.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[Home Lab Project]]
- [[tasks.md|Ongoing Tasks]]
