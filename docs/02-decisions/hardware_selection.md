# Hardware Selection Justification

This document outlines the rationale behind the specific hardware choices for the [[Home Lab Project]], balancing performance, budget, energy efficiency, noise, and future scalability.

---

## 1. Firewall PC

*   **Chosen Hardware:** [[03-infrastructure/firewall_pc.md|HP EliteDesk G3 SFF]] (Intel i5-6500, 8GB RAM, 120GB SSD)
    *   **Alternative Considered:** Dell OptiPlex 3050 Micro (i5-6500T).
    *   **Justification:** The HP SFF was chosen over the Micro PC primarily for its **superior PCIe expansion capabilities**, allowing for the easy and reliable installation of a [[llnotes/Intel-I350-T4-NIC.md|dedicated Intel I350-T4 PCIe NIC]]. While the i5-6500 (non-T) has a slightly higher TDP (65W vs 35W) than the i5-6500T, the actual power consumption difference at the low load of a [[network-firewall-overview.md|firewall]] is minimal. The enhanced reliability and ease of maintenance of a PCIe NIC over an M.2 or USB adapter were deemed paramount for this critical perimeter device. 8GB RAM and 120GB SSD are amply sufficient for [[05-software/opnsense.md|OPNsense]].

## 2. Kubernetes Master Nodes

*   **Chosen Hardware:** 3x [[03-infrastructure/k8s_masters.md|Dell OptiPlex 3050 Micro]] (Intel i5-6500T, 16GB RAM, 256GB M.2 NVMe SSD)
    *   **Justification:**
        *   **High Availability (HA):** 3 nodes ensure [[04-platform/high_availability_design.md|Kubernetes Control Plane HA]], a non-negotiable [[Enterprise Mimicry|enterprise best practice]].
        *   **Cost-Effectiveness:** The 3050 Micros with i5-6500T offer excellent value for the modest CPU demands of the [[llnotes/Kubernetes-Control-Plane.md|Kubernetes Control Plane]].
        *   **Efficiency:** 'T' series CPUs are low-power and quiet, ideal for 24/7 operation.
        *   **Storage:** [[llnotes/SSD.md|NVMe SSDs]] are crucial for low [[llnotes/Disk-I-O-Latency.md|latency]] [[llnotes/etcd.md|etcd]] operations.
        *   **RAM:** 16GB RAM is the recommended minimum for stable [[llnotes/etcd.md|etcd]] and control plane components.

## 3. Kubernetes Worker Nodes

*   **Chosen Hardware:**
    *   1x [[03-infrastructure/k8s_worker_hp.md|HP EliteDesk]] (Intel i5-8500, 64GB RAM) - Existing.
    *   1x [[03-infrastructure/k8s_worker_lenovo.md|Lenovo ThinkCentre M720s SFF]] (Intel i5-8500, 64GB RAM) - New Purchase.
    *   3x [[03-infrastructure/k8s_workers_dell.md|Dell OptiPlex 3050 Micro]] (Intel i5-6500T, 32GB RAM each) - New Purchase.
    *   **Justification:**
        *   **Hybrid Performance:** Combines powerful 8th Gen i5 (non-T) nodes for demanding applications (and [[Intel Quick Sync Video|hardware transcoding]]) with efficient 6th Gen i5-6500T nodes for general compute and [[07-storage/ceph_cluster_design.md|Ceph capacity]].
        *   **High RAM:** 64GB and 32GB RAM capacities provide ample memory for running numerous [[llnotes/Containerization.md|containerized applications]], [[05-software/applications#Databases (PostgreSQL)|databases]], and [[07-storage/ceph_cluster_design.md|Ceph caching]].
        *   **Storage Expansion:** The SFF (HP/Lenovo) nodes offer superior internal drive bays for multiple [[llnotes/HDD.md|HDDs]]/[[llnotes/SSD.md|SSDs]], crucial for scaling [[07-storage/ceph_cluster_design.md|Ceph OSDs]] for [[Archival Media Storage.md|media archives]] and general storage. Dell Micros contribute SSD-backed Ceph OSDs.
        *   **Resilience:** 5 worker nodes provide strong [[llnotes/Availability.md|HA]] for applications and [[07-storage/ceph_cluster_design.md|distributed storage]].

## 4. Dedicated NAS Server

*   **Chosen Hardware:** [[03-infrastructure/nas_server.md|Old Apple Tower 3.1]] (2x Xeon E5462, 16GB DDR2 RAM)
    *   **Justification:**
        *   **Cost-Effective Reuse:** Leverages existing hardware and its numerous 3.5" drive bays.
        *   **Bulk Storage:** Provides a dedicated, highly expandable platform for large [[Archival Media Storage.md|media archives]] using [[llnotes/ZFS.md|ZFS]] on [[TrueNAS SCALE|TrueNAS SCALE]].
        *   **Noise/Power Management:** Allows the [[llnotes/NAS-Server.md|NAS]] to be located in the garage, minimizing noise in living areas.
        *   **Separation of Concerns:** Separates less latency-sensitive bulk media from [[04-platform/kubernetes_distro|Kubernetes]] operational storage, allowing K8s workers to focus on compute/Ceph for apps.

## 5. Network Switches

*   **Chosen Hardware:** [[03-infrastructure/managed_switch.md|D-Link DGS-1210-16 Managed Switch]] (1GbE, fanless)
    *   **Justification:** Cost-effective, silent, energy-efficient, and provides essential [[llnotes/VLANs.md|VLAN]] support for [[Network Segmentation]]. Ideal for the [[LAN_K8S]] segment.
*   **Future PoE Switch:** [[03-infrastructure/managed_switch.md#Future Secondary PoE Managed Switch (Optional)|Future PoE Managed Switch]] (e.g., 8-port fanless)
    *   **Justification:** Dedicated power and data for [[llnotes/Security Cameras.md|security cameras]] and [[llnotes/IoT Devices.md|IoT Devices]], supporting the [[LAN_IOT_CAM]] segment.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[01-overview/architecture_overview.md|High-Level Architecture Overview]]
- [[02-decisions/README.md|Decisions Overview]]
- [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]
