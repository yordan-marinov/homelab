# Kubernetes Worker Node (HP EliteDesk)

## Hardware Specifications (1 Node - Existing)

*   **Model:** HP EliteDesk [Specify exact model, e.g., 800 G4 SFF]
*   **CPU:** Intel Core i5-8500 (6 cores, 6 threads, 3.0GHz base, 4.1GHz turbo, 65W TDP)
    *   **Features:** Supports [[llnotes/AES-NI.md|AES-NI]], [[Intel Quick Sync Video|Intel Quick Sync Video]] (for [[05-software/applications.md#Media Servers (Plex/Jellyfin)|media transcoding]]).
    *   **Justification:** Existing powerful hardware, high core count, excellent performance for demanding [[05-software/applications.md|applications]] and [[07-storage/ceph_cluster_design.md|Ceph]]. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
*   **RAM:** 64GB DDR4 (e.g., 2x32GB or 4x16GB configuration at 2666MHz)
    *   **Justification:** Abundant RAM provides significant headroom for memory-intensive [[05-software/applications.md#Databases (PostgreSQL)|databases]], [[07-storage/ceph_cluster_design.md#Ceph caching|Ceph caching]], and numerous applications.
*   **Storage:**
    *   **OS/K8s:** [e.g., 256GB-512GB M.2 NVMe [[llnotes/SSD.md|SSD]]].
    *   **Ceph OSDs:** Multiple [[llnotes/HDD.md|HDDs]]/[[llnotes/SSD.md|SSDs]] (e.g., 2x 4TB [[llnotes/HDD.md|HDDs]] + 1x 1TB [[llnotes/SSD.md|SSD]]).
    *   **Justification:** SFF form factor allows for multiple internal drives, making it ideal for large-capacity [[07-storage/ceph_cluster_design.md|Ceph OSDs]] for [[Archival Media Storage.md|media files]] and [[08-operations/backup_recovery.md|personal backups]].
*   **Network:** 1x 1GbE RJ-45 (onboard NIC)
*   **Power Supply Unit (PSU):** [e.g., 200W or 240W, typical for SFF]

## Software

*   **Operating System:** [[llnotes/Operating-System-(Nodes).md|Talos Linux]]
*   **Kubernetes:** [[04-platform/kubernetes_distro.md#Talos Kubernetes|Talos Kubernetes]] (as a worker node).
*   **Storage:** [[05-software/rook_ceph.md|Rook/Ceph]] (hosting Ceph OSDs).

## Role in Architecture

This node serves as a primary, high-performance [[llnotes/Kubernetes-Nodes.md#Worker Nodes|Kubernetes worker node]], especially suited for demanding [[05-software/applications.md|application workloads]] and providing significant [[07-storage/ceph_cluster_design.md|Ceph storage capacity]]. It is key for:
*   Running [[05-software/applications.md#Databases (PostgreSQL)|latency-sensitive databases]].
*   Hosting [[05-software/applications.md#Media Servers (Plex/Jellyfin)|media server]] instances due to its strong [[CPU]] and ample [[RAM]].
*   Contributing a large portion of the [[07-storage/ceph_cluster_design.md|distributed storage pool]].
*   Managed via [[llnotes/Talos-API.md|Talos API]] (using `talosctl`) due to [[llnotes/Immutable-infrastructure.md|immutable OS]] design.

---

## Related Links
- [[03-infrastructure/README.md|Infrastructure Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[04-platform/kubernetes_distro.md|Kubernetes Distribution & OS]]
- [[llnotes/Kubernetes-Nodes.md]]
- [[llnotes/SSD.md]]
- [[llnotes/HDD.md]]
- [[llnotes/ZFS.md]]
