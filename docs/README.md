# Home Lab Project: Enterprise-Grade Learning & Showcase Documentation

This document serves as the comprehensive overview and entry point for the **Home Lab Project**. It details the vision, objectives, core architectural principles, infrastructure breakdown, software stack, and key learning focus for this enterprise-grade, cloud-native learning platform.

All decisions, configurations, and lessons learned are meticulously documented across this `docs/` repository, reflecting a structured, process-driven approach to IT architecture and operations.

---

## 1. Project Vision & Overarching Goals

This project aims to build a **highly available (HA) and resilient bare-metal Kubernetes cluster**, integrated with a dedicated **ZFS-based NAS**, and secured by an **open-source perimeter firewall (OPNsense)**. The primary vision is to create a robust, enterprise-mimicking, cloud-native learning platform for professional development and a capable personal data center for home media and applications.

**Key Goals:**

*   **Professional Development:** Gain deep, hands-on experience in Kubernetes, distributed storage, advanced networking, security, and DevOps/SRE practices.
*   **Cloud-Native Mimicry:** Design and implement an architecture that closely reflects modern enterprise cloud environments (e.g., hyperconverged infrastructure, network segmentation, HA).
*   **High Availability & Resilience:** Ensure continuous operation for both core lab services and personal data, tolerating component failures.
*   **Resource Optimization:** Efficiently leverage refurbished hardware and maximize its utility for diverse workloads (compute, storage, security).
*   **Personal Cloud:** Host self-managed media streaming, file sharing, personal websites, and robust data backups.
*   **Cost & Efficiency:** Minimize upfront costs, ongoing electricity consumption, and operational noise in a home environment.

---

## 2. Core Architectural Principles & Key Decisions

The entire design is built upon these principles and the following critical decisions:

*   **Bare-Metal Kubernetes:** Chosen over traditional virtualization on nodes to gain direct hardware experience, reduce overhead, and closely mimic cloud provider infrastructure where Kubernetes often runs on highly optimized hosts.
*   **Dedicated OPNsense Firewall:** A powerful, open-source firewall PC acts as the single, central network gateway and security perimeter, eliminating Network Address Translation (NAT) complexities and enabling granular control across all network segments.
*   **Multi-Interface Firewall:** Utilizes all 5 Ethernet ports on the firewall for distinct physical network segments (WAN, K8s, IoT/Cam, Home Wi-Fi, Spare) to enforce deep network segmentation at the perimeter.
*   **VLAN-Based Network Segmentation:** Employs VLANs on managed switches to logically isolate different trust zones (Kubernetes nodes, management, storage) for enhanced security and simplified traffic management.
*   **Hybrid Storage Strategy:**
    *   **Operational Storage:** Ceph (via Rook) on Kubernetes worker nodes provides resilient, Kubernetes-native block and object storage for applications, databases, and logs, creating a hyperconverged infrastructure.
    *   **Archival/Bulk Media Storage:** A dedicated ZFS-based NAS (TrueNAS) for cost-effective, high-capacity, resilient storage of personal media files and long-term backups, separating less latency-sensitive bulk data from real-time operational needs.
*   **Refurbished Business Hardware:** Strategic use of cost-effective, energy-efficient, and robust HP/Dell mini/SFF PCs.
*   **Incremental Expansion:** The architecture allows for gradual addition of more storage, compute nodes, and advanced features.
*   **Prioritize RAM and Drive Bays:** Focus on machines with high RAM capacity and multiple internal drive bays for worker nodes to support Ceph and TrueNAS.
*   **Low Noise & Power:** Prioritizes 'T' series CPUs for efficiency and fanless switches/small form factors where feasible, optimizing for a home environment.
*   **Talos Linux for K8s OS:** Chosen for its Kubernetes-specific purpose, immutable architecture, enhanced security, and the valuable learning opportunity it provides in modern infrastructure management (implying API-driven management via `talosctl`).

---

## 3. Detailed Infrastructure Breakdown

This architecture comprises **1 Firewall PC + 3 Kubernetes Master Nodes + 4 Kubernetes Worker Nodes + 1 Dedicated TrueNAS Server**, totaling **9 Physical Machines**, plus essential networking gear.

### 3.1. Network Perimeter & Services (Firewall PC)

*   **Model:** HP EliteDesk G3 SFF
*   **CPU:** Intel Core i5-6500 (4 cores, 4 threads, 3.2GHz base, AES-NI support)
*   **RAM:** 8GB DDR4
*   **Storage:** 120GB SATA SSD (OS)
*   **NIC:** Intel I350-T4 (4x 1GbE RJ-45) + 1x Onboard 1GbE NIC = **5 total ports**
*   **Operating System:** OPNsense (bare-metal installation on ZFS)
*   **Role:** Main Router, DHCP Server, DNS Resolver, Firewall, VPN Server (future), Reverse Proxy (future), IDS/IPS (future).

### 3.2. Network Distribution (Managed Switches)

*   **Primary Managed Switch:** D-Link DGS-1210-16 (or similar 16/24-port fanless Smart Managed Switch)
    *   *Role:* Central wired distribution layer for the Kubernetes, Management PC, and TrueNAS segments.
*   **Future Secondary PoE Managed Switch (Optional):** (e.g., 8-port fanless PoE+ Managed Switch)
    *   *Role:* Distribution layer for the IoT/Camera segment.

### 3.3. Kubernetes Cluster (3 Masters + 4 Workers = 7 Nodes)

*   **Kubernetes Distribution:** K3s or Talos Kubernetes (if using Talos OS).
*   **Operating System:** Talos Linux (for security, immutability, API-driven management)

#### 3.3.1. Kubernetes Control Plane Nodes (3x Masters)

*   **Model:** 3x Dell OptiPlex 3050 Micro
*   **CPU:** Intel Core i5-6500T (4 cores, low power)
*   **RAM:** 16GB DDR4 (2x8GB)
*   **Storage:** 256GB M.2 NVMe SSD (OS)
*   *Note:* These nodes are dedicated and do NOT host Ceph OSDs to ensure maximum control plane stability.

#### 3.3.2. Kubernetes Worker Nodes (4x Workers)

*   **1x Performance Worker (Existing):**
    *   **Model:** HP EliteDesk (Intel i5-8500, 6 cores, 64GB RAM)
    *   **Storage:** 256GB-512GB M.2 NVMe SSD (OS) + multiple HDDs/SSDs for Ceph OSDs.
*   **1x Performance Worker (New):**
    *   **Model:** Lenovo ThinkCentre M720s SFF (Intel i5-8500, 6 cores, 64GB RAM)
    *   **Storage:** 256GB-512GB M.2 NVMe SSD (OS) + multiple HDDs/SSDs for Ceph OSDs.
*   **3x Capacity Workers (New):**
    *   **Model:** 3x Dell OptiPlex 3050 Micro (Intel i5-6500T, 4 cores, 32GB RAM each)
    *   **Storage (Each):** 256GB M.2 NVMe SSD (OS) + 256GB 2.5-inch SATA SSD (for Ceph OSD).
*   *Note:* All worker nodes contribute compute resources for applications, databases, and provide Ceph OSDs for distributed storage.

### 3.4. Dedicated NAS Server

*   **Model:** Old Apple Tower 3.1 (2x Xeon E5462)
*   **RAM:** 16GB DDR2 (upgraded)
*   **Storage:** Small SATA SSD (boot) + multiple large HDDs (data).
*   **Operating System:** TrueNAS SCALE (bare-metal on ZFS)
*   **Role:** Archival Media Storage, Network File Sharing (NFS/SMB), Backup Target.

### 3.5. Wi-Fi Infrastructure

*   **Repurposed Main Router:** (e.g., TP-Link Archer C60)
    *   *Role:* Configured as a dedicated Wi-Fi Access Point (AP) for the downstairs, connected to the Firewall PC's `LAN_HOME_WIFI` port.
*   **Repurposed Second Router:** (e.g., Older TP-Link Router)
    *   *Role:* Configured as a wireless extender/repeater, connecting wirelessly to the Main Router (AP) for upstairs coverage.

---

## 4. Key Software Stack

*   **Firewall OS:** OPNsense
*   **Kubernetes OS:** Talos Linux
*   **Kubernetes Distribution:** K3s or Talos Kubernetes (if using Talos OS).
*   **Distributed Storage (K8s):** Rook/Ceph
*   **NAS OS:** TrueNAS SCALE
*   **Monitoring:** Prometheus/Grafana
*   **Logging:** Loki/Fluentd
*   **Reverse Proxy/Ingress:** HAProxy (on OPNsense) / Nginx Ingress or Traefik (on K8s)
*   **DNS:** Unbound DNS (on OPNsense) + potential Pi-hole (on K8s).
*   **Applications:** Plex/Jellyfin, Nextcloud/Immich, PostgreSQL, custom web apps.

---

## 5. Key Learning & Skill Development Focus

This project provides a unique opportunity to demonstrate and master:

*   **Architectural Design:** End-to-end planning of complex, resilient, and secure IT infrastructure.
*   **DevOps/SRE Principles:** Implementing CI/CD, automation (IaC, GitOps), observability (monitoring, logging, alerting), and reliability engineering.
*   **Cloud-Native Technologies:** Deep expertise in Kubernetes, containers, distributed storage (Ceph), and API-driven management.
*   **Advanced Networking:** Designing and configuring multi-interface firewalls, VLANs, secure remote access (VPNs), and network segmentation.
*   **Security-First Operations:** Applying principles of least privilege, attack surface reduction, and robust authentication/authorization.
*   **Storage Management:** Proficiency in ZFS (TrueNAS) and distributed storage (Ceph) for diverse workloads.
*   **Troubleshooting:** Systematic problem-solving across hardware, firmware, network, and software layers.
*   **Documentation:** Structured knowledge management and project documentation for reproducibility and knowledge transfer.

---

## 6. Project Structure

The project documentation is organized for clarity and modularity. Refer to `index.md` for navigation.

---

## 7. Outcomes & Showcase

By maintaining this *homelab*, I aim to:

*   Demonstrate ability to **design and maintain enterprise-grade infrastructure** from bare metal to application.
*   Practice **security-focused operations** in a realistic environment with advanced tools.
*   Create **reusable templates and automation** for future projects, embodying IaC and GitOps.
*   Maintain **hands-on expertise with current industry tools** (Kubernetes, OPNsense, TrueNAS, Prometheus, Grafana, Talos Linux, Ceph).
*   Showcase **seniority in planning, architecture, and operational management**, proving structured, process-driven thinking.

---

## 8. Philosophy

> "Build like you run production, learn like it’s your sandbox. Document everything."
