# Hardware Selection Justification

This document outlines the rationale behind the specific hardware choices for the Home Lab Project, balancing performance, budget, energy efficiency, noise, and future scalability. Each component decision supports the overarching [[01-overview/goals.md|project goals]].

---

## 1. Firewall PC

* **Chosen Hardware:** [[03-infrastructure/firewall_pc.md|HP EliteDesk G3 SFF]] (Intel i5-6500, 8GB RAM, 120GB SSD)
  * **Alternative Considered:** Dell OptiPlex 3050 Micro (i5-6500T).
  * **Justification:** The HP SFF was chosen over the Micro PC primarily for its **superior PCIe expansion capabilities**, allowing for the easy and reliable installation of a dedicated Intel I350-T4 PCIe NIC. While the i5-6500 (non-'T') has a slightly higher TDP (65W vs 35W for 'T' series) than the i5-6500T, the actual power consumption difference at the low load of a firewall is minimal. The enhanced reliability and ease of maintenance of a PCIe NIC over an M.2 or USB adapter were deemed paramount for this critical perimeter device. 8GB RAM and 120GB SSD are amply sufficient for [[05-software/opnsense.md|OPNsense]].

## 2. Management/Utility Host

* **Chosen Hardware:** [[03-infrastructure/management_utility_host.md|Dell OptiPlex 3050 Micro]] (Intel i5-6500T, 8GB RAM, 256GB 2.5" SATA SSD + 1TB M.2 NVMe SSD)
  * **Alternatives Considered:** Using a larger SFF PC (e.g., HP EliteDesk i5-8500) for this role.
  * **Justification:** This Dell Micro (with its efficient i5-6500T CPU) provides **sufficient compute resources** for running [[05-software/proxmox_ve.md|Proxmox VE]] and multiple LXC containers (Omni, Prometheus, Grafana, Loki, AdGuard Home, HomePage). Its low power consumption and quiet operation are ideal for a 24/7 centralized management plane that operates *outside* the Kubernetes cluster. The 1TB NVMe provides fast I/O for observability databases. This decision optimizes resource allocation and minimizes energy use for the management plane.

## 3. Kubernetes Master Nodes

* **Chosen Hardware:** 3x [[03-infrastructure/k8s_masters.md|Dell OptiPlex 3050 Micro]] (Intel i5-6500T, 16GB RAM, 256GB M.2 NVMe SSD)
  * **Justification:**
    * **High Availability (HA):** 3 nodes ensure Kubernetes Control Plane HA, a non-negotiable enterprise best practice.
    * **Cost-Effectiveness:** The 3050 Micros with i5-6500T offer excellent value for the modest CPU demands of the Kubernetes Control Plane.
    * **Efficiency:** 'T' series CPUs are low-power and quiet, ideal for 24/7 operation.
    * **Storage:** NVMe SSDs are crucial for low latency etcd operations.
    * **RAM:** 16GB RAM (2x8GB) is the recommended minimum for stable etcd and control plane components.

## 4. Kubernetes Worker Nodes

* **Chosen Hardware:**
  * 1x [[03-infrastructure/k8s_worker_hp.md|HP EliteDesk]] (Intel i5-8500, 64GB RAM) - Existing.
  * 2x [[03-infrastructure/k8s_workers_dell.md|Dell OptiPlex 3050 Micro]] (Intel i5-6500T, 32GB RAM each) - New Purchase.
  * **Justification:**
    * **Hybrid Performance:** Combines the powerful 8th Gen i5 (non-'T') node for demanding applications (and Intel Quick Sync Video hardware transcoding) with efficient 6th Gen i5-6500T nodes for general compute and Ceph capacity.
    * **High RAM:** 64GB and 32GB RAM capacities provide ample memory for running numerous containerized applications, databases, and Ceph caching.
    * **Storage Expansion:** The SFF (HP) node offers superior internal drive bays for multiple HDDs/SSDs, crucial for scaling Ceph OSDs for media archives and general storage. Dell Micros contribute SSD-backed Ceph OSDs.
    * **Resilience:** 3 worker nodes provide strong HA for applications and distributed storage.

## 5. Dedicated NAS Server

* **Chosen Hardware:** [[03-infrastructure/nas_server.md|Old Apple Tower 3.1]] (2x Xeon E5462, 16GB DDR2 RAM)
  * **Justification:**
    * **Cost-Effective Reuse:** Leverages existing hardware and its numerous 3.5" drive bays.
    * **Bulk Storage:** Provides a dedicated, highly expandable platform for large media archives using ZFS on [[05-software/truenas_scale.md|TrueNAS SCALE]].
    * **Noise/Power Management:** Allows the NAS to be located in the garage, minimizing noise in living areas.
    * **Separation of Concerns:** Separates less latency-sensitive bulk media from Kubernetes operational storage, allowing K8s workers to focus on compute/Ceph for applications.

## 6. Network Switches

* **Chosen Hardware:** [[03-infrastructure/managed_switch.md|D-Link DGS-1210-16 Managed Switch]] (1GbE, fanless)
  * **Justification:** Cost-effective, silent, energy-efficient, and provides essential VLAN support for network segmentation. Ideal for the Kubernetes/Management/NAS segment.
* **Future PoE Switch:** [[03-infrastructure/managed_switch.md#Future Secondary PoE Managed Switch (Optional)|Future PoE Managed Switch]] (e.g., 8-port fanless PoE+ Managed Switch)
  * **Justification:** Dedicated power and data for security cameras and IoT Devices, supporting the IoT/Camera segment.

---

## Related Links
* [[01-overview/README.md|Project Overview]]
* [[02-decisions/README.md|Decisions Overview]]
* [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]
