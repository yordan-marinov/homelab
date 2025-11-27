# Storage Strategy (Hybrid: Ceph on K8s + TrueNAS)

This document details the hybrid [[storage]] strategy adopted for the [[Home Lab Project]], combining the strengths of [[07-storage/ceph_cluster_design.md|Ceph on Kubernetes]] for operational data and a dedicated [[llnotes/NAS-Server.md|TrueNAS server]] for [[Archival Media Storage.md|bulk media archiving]].

---

## 1. Ceph on Kubernetes (Operational Storage)

*   **Decision:** Deploy [[05-software/rook_ceph.md|Rook/Ceph]] on [[04-platform/kubernetes_distro#Kubernetes Nodes|Kubernetes worker nodes]] using their local [[llnotes/SSD.md|SSDs]] and [[llnotes/HDD.md|HDDs]].
*   **Justification:**
    *   **[[Kubernetes-Native Storage]]:** Provides [[07-storage/persistent_storage.md|Persistent Volumes]] directly via the [[Container Storage Interface (CSI).md|CSI]] for [[05-software/applications|applications]] and [[05-software/applications#Databases (PostgreSQL)|databases]] running within [[Kubernetes]].
    *   **[[llnotes/Hyperconverged-Infrastructure-(HCI).md|Hyperconverged Infrastructure (HCI)]]:** Aligns with [[cloud-native]] best practices by integrating compute and [[storage]] on the same nodes.
    *   **[[llnotes/Availability.md|High Availability]] & [[llnotes/Data-Integrity.md|Resilience]]:** [[llnotes/Ceph]] inherently replicates data across multiple nodes, protecting against individual drive or node failures.
    *   **Performance:** SSD-backed [[07-storage/ceph_cluster_design.md|Ceph OSDs]] offer good performance for [[llnotes/Kubernetes]] application data.
    *   **Learning Value:** Provides deep, hands-on experience with a complex, distributed [[storage]] system in a [[Kubernetes]] environment.
*   **Role:** Primarily for application data, [[05-software/applications#Databases (PostgreSQL)|databases]], [[05-software/logging.md|logs]], and any operational files managed by [[Kubernetes]].

## 2. Dedicated TrueNAS Server (Archival/Bulk Media Storage)

*   **Decision:** Utilize a [[03-infrastructure/nas_server.md|dedicated Apple Tower 3.1]] running [[TrueNAS SCALE|TrueNAS SCALE]] (on [[llnotes/ZFS.md|ZFS]]) for bulk media and long-term archives.
*   **Justification:**
    *   **Cost-Effective Capacity:** Leveraging the Apple Tower's numerous 3.5" drive bays for large, [[llnotes/HDD.md|HDD-based]] [[storage]] offers the best cost-per-TB for massive [[Archival Media Storage.md|media libraries]].
    *   **Simplicity for [[File Sharing|File Sharing]]:** [[TrueNAS SCALE]] is explicitly designed for easy [[File Sharing|file sharing]] ([[llnotes/SMB-(Server-Message-Block).md|SMB]], [[llnotes/NFS-(Network-File-System).md|NFS]]) to non-[[Kubernetes]] client devices and media players.
    *   **[[llnotes/ZFS.md|ZFS]] for [[llnotes/Data-Integrity.md|Data Integrity]]:** Provides robust [[Data Integrity|data protection]] and [[llnotes/ZFS-Snapshots.md|snapshots]] for irreplaceable personal media.
    *   **Performance:** A dedicated [[llnotes/NAS-Server.md|NAS]] with optimized [[llnotes/RAID.md|RAID-like ZFS pools]] can offer excellent sustained [[File Sharing|file transfer]] performance for [[05-software/applications#Media Servers (Plex/Jellyfin)|media streaming]].
    *   **Reduced Overhead on K8s:** Offloads massive, less latency-sensitive [[storage]] from the [[Kubernetes]] worker nodes, allowing them to focus more on compute.
    *   **Noise Management:** Allows the [[llnotes/NAS-Server.md|NAS]] to be located in the garage.
*   **Role:** Primary repository for all personal pictures, videos, music, books, and serving as an external [[08-operations/backup_recovery.md|backup target]] for selected [[Kubernetes]] data.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[02-decisions/README.md|Decisions Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]
