# Kubernetes Worker Nodes (Dell OptiPlex 3050 Micro)

## Hardware Specifications (3 Nodes)

*   **Model:** Dell OptiPlex 3050 Micro
*   **CPU:** Intel Core i5-6500T (4 cores, 4 threads, 2.5GHz base, 3.1GHz turbo, 35W TDP)
    *   **Features:** Supports [[llnotes/AES-NI.md|AES-NI]], [[Intel Quick Sync Video|Intel Quick Sync Video]] (for [[05-software/applications.md#Media Servers (Plex/Jellyfin)|media transcoding]]).
    *   **Justification:** Cost-effective, low power consumption, quiet, contributes to [[04-platform/high_availability_design.md|HA]] and [[07-storage/ceph_cluster_design.md|Ceph capacity]]. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
*   **RAM:** 32GB DDR4 (2x16GB configuration at 2400MHz or 2666MHz)
    *   **Justification:** Crucial for [[07-storage/ceph_cluster_design.md|Ceph performance]] and running multiple [[llnotes/Containerization.md|containerized applications]] and [[05-software/applications.md#Databases (PostgreSQL)|databases]].
*   **Storage:**
    *   **OS/K8s:** 256GB M.2 NVMe [[llnotes/SSD.md|SSD]] (for OS and [[llnotes/Kubernetes-cluster.md|Kubernetes]] binaries).
    *   **Ceph OSD:** 256GB 2.5-inch SATA [[llnotes/SSD.md|SSD]] (existing drive, repurposed for [[07-storage/ceph_cluster_design.md|Ceph OSD]]).
    *   **Justification:** [[llnotes/SSD.md|SSD-backed Ceph OSDs]] offer good performance and contribute to [[07-storage/ceph_cluster_design.md|distributed storage resilience]] within budget.
*   **Network:** 1x 1GbE RJ-45 (onboard NIC)
*   **Power Supply Unit (PSU):** [e.g., 65W or 90W external brick, typical for Micro]

## Software

*   **Operating System:** [[llnotes/Operating-System-(Nodes).md|Talos Linux]]
*   **Kubernetes:** [[04-platform/kubernetes_distro.md#Talos Kubernetes|Talos Kubernetes]] (as worker nodes).
*   **Storage:** [[05-software/rook_ceph.md|Rook/Ceph]] (hosting Ceph OSDs).

## Role in Architecture

These three nodes serve as dedicated [[llnotes/Kubernetes-Nodes.md#Worker Nodes|Kubernetes worker nodes]], executing [[05-software/applications.md|application workloads]] and contributing to the distributed [[07-storage/ceph_cluster_design.md|Ceph storage cluster]]. They are key for:
*   Providing compute resources for [[llnotes/Containerization.md|containerized applications]] and [[05-software/applications.md#Databases (PostgreSQL)|databases]].
*   Hosting [[07-storage/ceph_cluster_design.md|Ceph OSDs]], contributing to the overall [[07-storage/ceph_cluster_design.md#Ceph Resilience|storage capacity]] and [[07-storage/ceph_cluster_design.md#Ceph Resilience|resilience]].
*   Acting as part of the horizontally scaled compute and storage pool.
*   Managed via [[llnotes/Talos-API.md|Talos API]] (using `talosctl`) due to [[llnotes/Immutable-infrastructure.md|immutable OS]] design.

---

## Related Links
- [[03-infrastructure/README.md|Infrastructure Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[04-platform/kubernetes_distro.md|Kubernetes Distribution & OS]]
- [[llnotes/Kubernetes-Nodes.md]]
- [[llnotes/SSD.md]]
- [[llnotes/ZFS.md]]
