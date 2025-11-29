# High-Level Architecture Overview

This section elaborates on the core architectural principles and key design decisions that underpin the Home Lab Project, providing a conceptual framework for the entire infrastructure. These principles guide the selection of hardware, software, and configuration strategies.

---

## 1. Core Architectural Principles

* **Bare-Metal Kubernetes & Immutable Infrastructure:**
  * **Principle:** Direct control over hardware, minimal virtualization overhead.
  * **Impact:** Enhanced performance and direct learning about hardware-software interaction, closely mimicking cloud provider infrastructure.
  * **Decision:** Talos Linux for Kubernetes hosts (see [[04-platform/kubernetes_distro.md|Kubernetes Distribution & OS]]).
* **Dedicated OPNsense Firewall (Perimeter Security):**
  * **Principle:** Single, central security gateway for all network traffic.
  * **Impact:** Eliminates Double-NAT, enables granular security and network segmentation.
  * **Decision:** [[03-infrastructure/firewall_pc.md|HP EliteDesk G3 SFF]] running [[05-software/opnsense.md|OPNsense]].
* **Multi-Interface Firewall:**
  * **Principle:** Physical separation of major network segments at the firewall level.
  * **Impact:** Maximize isolation and provide dedicated bandwidth for each zone.
  * **Decision:** Utilizing all 5 Ethernet ports on the [[03-infrastructure/firewall_pc.md|Firewall PC]] (WAN, LAN_K8S, LAN_IOT_CAM, LAN_HOME_WIFI, OPT1/SPARE).
* **VLAN-Based Network Segmentation:**
  * **Principle:** Logical isolation of different trust zones within a physical segment.
  * **Impact:** Enhanced security, improved network administration, and traffic control.
  * **Decision:** VLANs on the [[03-infrastructure/managed_switch.md|D-Link Managed Switch]] for LAN_K8S (Kubernetes nodes, management).
* **Hybrid Storage Strategy:**
  * **Principle:** Optimize storage for different workload types (operational vs. archival).
  * **Impact:** Resilient, Kubernetes-native storage for apps (Ceph) and cost-effective bulk storage for media (TrueNAS).
  * **Decision:** Ceph (via Rook) on Kubernetes workers + dedicated ZFS-based TrueNAS server.
* **Refurbished Business Hardware:**
  * **Principle:** Cost-effective acquisition of reliable, energy-efficient hardware.
  * **Impact:** Builds a powerful, multi-node lab on a budget.
  * **Decision:** Mix of HP EliteDesk and Dell OptiPlex Micro/SFF PCs.
* **Incremental Expansion:**
  * **Principle:** Design for future growth and flexibility.
  * **Impact:** Allows gradual addition of resources as needs and budget evolve.
  * **Decision:** Start with core nodes, plan for adding more Kubernetes worker nodes and storage drives.
* **Low Noise & Power:**
  * **Principle:** Optimize for a comfortable home environment and controlled operating costs.
  * **Impact:** Sustainable 24/7 operation.
  * **Decision:** Prioritize 'T' series CPUs where sufficient, fanless switches, and quiet SFF PCs.
* **Dedicated Management Plane (Proxmox Host):**
  * **Principle:** Centralize critical infrastructure management components *outside* the managed Kubernetes cluster.
  * **Impact:** Improves resilience (monitoring works even if K8s is down), enhances security through isolation, and maximizes utilization of a powerful host.
  * **Decision:** [[03-infrastructure/management_utility_host.md|Dell OptiPlex 3050 Micro (i5-6500T, 8GB RAM)]] running [[05-software/proxmox_ve.md|Proxmox VE]] (see [[02-decisions/management_plane_design.md|Management Plane Design]] for details).
* **Stateful Apps (DBs/Brokers/Media Servers) on K8s:**
  * **Principle:** Leverage Kubernetes' native HA capabilities for stateful workloads.
  * **Impact:** Fulfills core learning goals of running databases, message brokers, and media servers on a Kubernetes cluster with Ceph.
  * **Decision:** PostgreSQL, message brokers, and media servers run as containers on the Kubernetes cluster, using Ceph for persistent storage.

---

## 2. High-Level Architectural Diagram

This diagram provides a conceptual overview of the main components and their interconnections. For a detailed physical layout, refer to [[06-network/physical_topology.md]].

```mermaid
graph TD
    A[Internet] --> B(ISP Modem)
    B --> |WAN Interface| C(OPNsense Firewall PC)

    subgraph Internal Network Segments (Managed by OPNsense)
        C --> |LAN_K8S| D[Managed Switch 1 (for K8s/Mgmt/NAS)]
        C --> |LAN_IOT_CAM| E[Future PoE Managed Switch]
        C --> |LAN_HOME_WIFI| F[Repurposed Main Wi-Fi AP]
        C --> |LAN_NAS| G[TrueNAS Server]
        C --> |OPT1/SPARE| H[Spare Interface]
    end

    subgraph Kubernetes Cluster (on LAN_K8S Segment via Managed Switch 1)
        D --> K1(K8s Master 1)
        D --> K2(K8s Master 2)
        D --> K3(K8s Master 3)
        D --> W1(K8s Worker 1)
        D --> W2(K8s Worker 2)
        D --> W3(K8s Worker 3)
    end

    subgraph Management Plane (on LAN_K8S Segment via Managed Switch 1)
        D --> MgtHost(Management/Utility Host - Proxmox)
        MgtHost -- LXC: Omni --> K8sMgt(K8s Management)
        MgtHost -- LXC: Monitoring --> K8sMon(K8s Monitoring)
        MgtHost -- LXC: Logging --> K8sLog(K8s Logging)
        MgtHost -- VNC/SSH --> User(Your Laptop/Management Device)
    end

    subgraph Storage Strategy
        direction LR
        W1 -- Ceph OSDs --> S1(Distributed Storage Pool)
        W2 -- Ceph OSDs --> S1
        W3 -- Ceph OSDs --> S1
        S1 -- K8s Persistent Volumes --> K8sApplications(K8s Applications/DBs/Media)
        G -- ZFS Pools --> S2(TrueNAS ZFS Pools)
        S2 -- NFS/SMB Shares --> MediaApps(Media Servers / File Shares)
        S1 -- Backup Target --> S2
    end

    subgraph Wi-Fi Infrastructure (on LAN_HOME_WIFI Segment)
        F --> WL1(Wi-Fi Devices)
        F --> WL2(Wi-Fi Extender Upstairs)
        WL2 --> WLD(Other Wired Devices)
    end

    style C fill:#f9f,stroke:#333,stroke-width:2px
    style G fill:#ccf,stroke:#333,stroke-width:2px
    style K1 fill:#bbf,stroke:#333,stroke-width:1px
    style K2 fill:#bbf,stroke:#333,stroke-width:1px
    style K3 fill:#bbf,stroke:#333,stroke-width:1px
    style W1 fill:#e6ffed,stroke:#333,stroke-width:1px
    style W2 fill:#e6ffed,stroke:#333,stroke-width:1px
    style W3 fill:#e6ffed,stroke:#333,stroke-width:1px
    style MgtHost fill:#ffe0e6,stroke:#333,stroke-width:2px
    style S1 fill:#ffc,stroke:#333,stroke-width:1px
    style S2 fill:#ffc,stroke:#333,stroke-width:1px
