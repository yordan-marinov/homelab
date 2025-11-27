# Dedicated NAS Server (Apple Tower 3.1)

## Hardware Specifications (1 Node - Repurposed Existing)

*   **Model:** Apple Tower 3.1 (Mac Pro 2008, A1186)
*   **CPU:** 2x Intel Xeon E5462 @ 2.80GHz (8 cores total, LGA 771, 80W TDP per CPU)
    *   **Features:** Multi-core processing for [[llnotes/ZFS.md|ZFS]] operations and [[File Sharing|file serving]].
    *   **Justification:** Leverages existing hardware. While older and less power-efficient, its numerous 3.5" drive bays are ideal for cost-effective, high-capacity bulk [[Archival Media Storage.md|media storage]]. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
*   **RAM:** 16GB DDR2 FB-DIMMs (Upgraded from original 8GB)
    *   **Justification:** [[llnotes/ZFS.md|ZFS]] is memory-hungry; 16GB is the recommended minimum for stable and performant [[llnotes/ZFS.md|ZFS]] pools.
*   **Storage:**
    *   **Boot Drive:** Small 16GB/32GB SATA [[llnotes/SSD.md|SSD]] (planned purchase, will install into a 2.5" adapter in a 3.5" bay).
        *   *Justification:* Provides fast boot for [[TrueNAS SCALE|TrueNAS SCALE]]. More reliable than USB boot.
    *   **Data Drives (Initial):** 1x 3.5" SATA 320GB [[llnotes/HDD.md|HDD]], 1x 2.5" SATA 250GB [[llnotes/HDD.md|HDD]] (with 3.5" adapter).
    *   **Data Drives (Future):** Up to **4 additional large [[llnotes/HDD.md|HDDs]]** (future purchase) to fill its 6 internal 3.5" drive bays.
    *   **Justification:** Maximizes capacity for [[Archival Media Storage.md|bulk media archiving]]. Utilizes [[llnotes/ZFS.md|ZFS]] for [[llnotes/Data-Integrity.md|data integrity]] and [[llnotes/RAID.md|redundancy]].
*   **Network:** 1x 1GbE RJ-45 (onboard NIC).
*   **Power Supply Unit (PSU):** Original built-in PSU (approx. 980W).
    *   *Note: High capacity PSU, but overall system power consumption is higher due to older CPU architecture.*

## Software

*   **Operating System:** [[05-software/truenas_scale.md|TrueNAS SCALE]] (bare-metal installation on ZFS).

## Role in Architecture

This dedicated NAS server provides the [[llnotes/Archival-Media-Storage.md|Archival Media Storage]] component of the [[Home Lab Project]]'s hybrid [[storage]] strategy. It is essential for:
*   **Bulk Media Storage:** Primary repository for all personal pictures, videos, music, books.
*   **[[File Sharing|Network File Sharing]]:** Provides [[llnotes/NFS-(Network-File-System).md|NFS]] and [[llnotes/SMB-(Server-Message-Block).md|SMB]] shares for client devices and [[Kubernetes]] media servers.
*   **[[08-operations/backup_recovery.md|Backup Target]]:** Serves as an external backup target for critical data from the [[07-storage/ceph_cluster_design.md|Kubernetes Ceph cluster]] (e.g., [[llnotes/etcd.md|etcd snapshots]], important configs).
*   **Noise Management:** Located in the garage to minimize operational noise in living areas.
*   **Network Isolation:** Connected to its own dedicated [[LAN_NAS]] interface on the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]].

