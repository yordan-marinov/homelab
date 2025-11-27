# High-Level Architecture Overview

This section elaborates on the core architectural principles and key design decisions that underpin the [[Home Lab Project]], providing a conceptual framework for the entire infrastructure. These principles guide the selection of hardware, software, and configuration strategies.

---

## 1. Core Architectural Principles

*   **Bare-Metal Kubernetes:**
    *   **Principle:** Direct control over hardware, minimal [[llnotes/Virtualization|virtualization overhead]].
    *   **Impact:** Enhanced performance and direct learning about hardware-software interaction, closely mimicking cloud provider infrastructure.
    *   **Decision:** [[Talos Linux]] for Kubernetes hosts (see [[04-platform/kubernetes_distro.md|Kubernetes Distribution & OS]]).
*   **Dedicated OPNsense Firewall (Perimeter Security):**
    *   **Principle:** Single, central security gateway for all network traffic.
    *   **Impact:** Eliminates [[llnotes/Double-NAT|Double-NAT]], enables granular [[Network Security|security]] and [[Network Segmentation]].
    *   **Decision:** [[03-infrastructure/firewall_pc.md|HP EliteDesk G3 SFF]] running [[05-software/opnsense|OPNsense]].
*   **Multi-Interface Firewall:**
    *   **Principle:** Physical separation of major network segments at the firewall level.
    *   **Impact:** Maximize [[Network Security|isolation]] and provide dedicated bandwidth for each zone.
    *   **Decision:** Utilizing all 5 Ethernet ports on the [[03-infrastructure/firewall_pc|Firewall PC]] (WAN, [[LAN_K8S]], [[LAN_IOT_CAM]], [[LAN_HOME_WIFI]], [[llnotes/OPT_SPARE|Spare]]).
*   **VLAN-Based Network Segmentation:**
    *   **Principle:** Logical isolation of different trust zones within a physical segment.
    *   **Impact:** Enhanced [[Network Security]], improved [[Network Administration|management]], and traffic control.
    *   **Decision:** [[llnotes/VLANs|VLANs]] on the [[03-infrastructure/managed_switch|D-Link Managed Switch]] for [[LAN_K8S]] (Kubernetes nodes, management, storage).
*   **Hybrid Storage Strategy:**
    *   **Principle:** Optimize storage for different workload types (operational vs. archival).
    *   **Impact:** Resilient, Kubernetes-native storage for apps (Ceph) and cost-effective bulk storage for media (TrueNAS).
    *   **Decision:** [[07-storage/ceph_cluster_design.md|Ceph (via Rook)]] on Kubernetes workers + dedicated [[llnotes/NAS-Server|ZFS-based TrueNAS server]].
*   **Refurbished Business Hardware:**
    *   **Principle:** Cost-effective acquisition of reliable, energy-efficient hardware.
    *   **Impact:** Builds a powerful, multi-node lab on a budget.
    *   **Decision:** Mix of HP EliteDesk, Lenovo ThinkCentre, and Dell OptiPlex Micro/SFF PCs.
*   **Incremental Expansion:**
    *   **Principle:** Design for future growth and flexibility.
    *   **Impact:** Allows gradual addition of resources as needs and budget evolve.
    *   **Decision:** Start with core nodes, plan for adding more [[04-platform/kubernetes_distro#Kubernetes Nodes|Kubernetes worker nodes]] and [[llnotes/HDD|storage drives]].
*   **Low Noise & Power:**
    *   **Principle:** Optimize for a comfortable home environment and controlled operating costs.
    *   **Impact:** Sustainable 24/7 operation.
    *   **Decision:** Prioritize 'T' series CPUs where sufficient, fanless switches, and quiet SFF PCs.

---

## 2. High-Level Architectural Diagram

This diagram provides a conceptual overview of the main components and their interconnections. For a detailed physical layout, refer to [[06-network/physical_topology.md]].

```mermaid
graph TD
    A[Internet] --> B(ISP Modem)
    B --> |WAN Interface| C(OPNsense Firewall PC)

    subgraph Internal Network Segments (Managed by OPNsense)
        C --> |LAN_K8S| D[D-Link Managed Switch]
        C --> |LAN_IOT_CAM| E[Future PoE Managed Switch]
        C --> |LAN_HOME_WIFI| F[Repurposed Main Wi-Fi AP]
        C --> |OPT1/SPARE| G[TrueNAS Server]
    end

    subgraph Kubernetes Cluster (on LAN_K8S Segment)
        D --> K1(K8s Master 1)
        D --> K2(K8s Master 2)
        D --> K3(K8s Master 3)
        D --> W1(K8s Worker 1)
        D --> W2(K8s Worker 2)
        D --> W3(K8s Worker 3)
        D --> W4(K8s Worker 4)
        D --> W5(K8s Worker 5)
        D --> M(Management PC - Virtual/VPN)
    end

    subgraph Storage Strategy
        direction LR
        W1 -- Ceph OSDs --> S1(Distributed Storage Pool)
        W2 -- Ceph OSDs --> S1
        W3 -- Ceph OSDs --> S1
        W4 -- Ceph OSDs --> S1
        W5 -- Ceph OSDs --> S1
        G --> S2(TrueNAS ZFS Pools)
        S1 -- K8s Persistent Volumes --> K8sApplications(K8s Applications/DBs)
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
    style W4 fill:#e6ffed,stroke:#333,stroke-width:1px
    style W5 fill:#e6ffed,stroke:#333,stroke-width:1px
    style S1 fill:#ffc,stroke:#333,stroke-width:1px
    style S2 fill:#ffc,stroke:#333,stroke-width:1px
