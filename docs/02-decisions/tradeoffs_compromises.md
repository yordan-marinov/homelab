# Trade-offs & Compromises

This document details the conscious trade-offs and compromises made during the design and implementation of the [[Home Lab Project]]. While aiming for [[Enterprise Mimicry]], practical constraints (budget, noise, power consumption, available hardware) necessitated strategic decisions.

---

## 1. Firewall PC (HP EliteDesk G3 SFF)

*   **Trade-off:** Slightly higher power consumption (i5-6500 non-'T' CPU) compared to a Micro PC with a 'T' series CPU.
*   **Compromise:** Minor increase in running cost.
*   **Justification:** Prioritized the **ease and reliability of installing a standard [[llnotes/Intel-I350-T4-NIC.md|PCIe Intel I350-T4 NIC]]** over an M.2 or USB adapter, as a custom-built firewall requires robust and flexible [[Networking Fundamentals|network interfaces]]. The actual CPU load on the firewall is low, so the real-world power difference is manageable.

## 2. Kubernetes Master Nodes (Dell OptiPlex 3050 Micro)

*   **Trade-off:** Using Micro PCs with limited internal drive bays for masters.
*   **Compromise:** No local storage contribution to [[07-storage/ceph_cluster_design.md|Ceph]].
*   **Justification:** Masters are dedicated to the [[llnotes/Kubernetes-Control-Plane.md|Kubernetes Control Plane]] and [[llnotes/etcd.md|etcd]], which demand low [[llnotes/Disk-I-O-Latency.md|I/O latency]] and maximum stability. Keeping them separate from [[07-storage/ceph_cluster_design.md|Ceph OSDs]] is a [[Network Security|security]] and [[llnotes/Availability.md|HA]] best practice. The small form factor and efficient 'T' CPUs are ideal for this role.

## 3. Kubernetes Worker Nodes (Dell OptiPlex 3050 Micro)

*   **Trade-off:** Limited internal drive bays (1x M.2, 1x 2.5-inch) on Micro PCs, restricting the number of local [[llnotes/HDD.md|HDDs]] for [[07-storage/ceph_cluster_design.md|Ceph OSDs]].
*   **Compromise:** Less raw [[storage]] capacity per node compared to larger SFF machines, potentially relying more on larger SFF worker nodes for bulk Ceph.
*   **Justification:** Cost-effectiveness and low power/noise were paramount for these 3 nodes. They still provide valuable [[llnotes/SSD.md|SSD-backed Ceph OSDs]] contributing to [[07-storage/ceph_cluster_design.md|distributed storage resilience]] and total cluster [[RAM]]/[[CPU]] resources. Their compact size helps achieve a high node count for [[04-platform/high_availability_design.md|HA]].

## 4. Dedicated NAS Server (Apple Tower 3.1)

*   **Trade-off:** Using an older, potentially power-hungry, and noisy (if fans are old) Apple Tower.
*   **Compromise:** Higher long-term electricity cost and potential noise.
*   **Justification:** Leverages existing hardware. The **overwhelming benefit of its numerous 3.5" drive bays** for cost-effective, high-capacity [[Archival Media Storage.md|bulk media storage]] via [[llnotes/ZFS.md|ZFS]] (for TrueNAS) was deemed more important than the efficiency of a newer, dedicated NAS appliance. Locating it in the garage helps mitigate noise. This decision separates bulk archival storage from [[Kubernetes]] operational storage.

## 5. Network Switches (1GbE Only)

*   **Trade-off:** Initial reliance on 1GbE [[llnotes/Managed-Switch.md|managed switches]] only.
*   **Compromise:** Potential [[Networking Fundamentals|bandwidth]] bottleneck for very high-speed internal transfers (e.g., between [[07-storage/ceph_cluster_design|Ceph OSDs]] or [[05-software/applications#Databases (PostgreSQL)|databases]]) or future multi-gig [[Internet]] connections.
*   **Justification:** Prioritized **cost-effectiveness, silent operation (fanless), and energy efficiency** for the initial build. [[llnotes/Cat5e.md|Cat5e cabling]] is compatible with [[llnotes/2.5GbE.md|2.5GbE]] for future upgrades, and a dedicated [[llnotes/10GbE.md|10GbE]] switch can be added later if bottlenecks are observed.

## 6. Management Access (Wi-Fi Only Laptop)

*   **Trade-off:** Management laptop connects via [[llnotes/Wi-Fi.md|Wi-Fi]] instead of a dedicated wired [[Management VLAN.md|Management VLAN]].
*   **Compromise:** Slightly increased [[Network Security|security risk]] (Wi-Fi is inherently less secure than wired), potential [[Networking Fundamentals|bandwidth]] limitations for management tasks.
*   **Justification:** Based on the current physical constraint (laptop Ethernet driver issue and cluster location). [[llnotes/VPN.md|VPN]] access will be used to place the laptop virtually onto the [[LAN_K8S]] network, mitigating security concerns. [[06-network/opnsense_firewall_rules.md|Strict firewall rules]] further isolate the [[LAN_HOME_WIFI]] segment.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[02-decisions/README.md|Decisions Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[02-decisions/software_os_choices.md|Software & Operating System Choices]]
- [[02-decisions/network_topology_decisions.md|Network Topology Decisions]]
- [[02-decisions/storage_strategy.md|Storage Strategy (Ceph on K8s + TrueNAS)]]
