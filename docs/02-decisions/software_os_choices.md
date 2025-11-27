# Software & Operating System Choices

This document details the rationale behind the primary software and operating system selections for the [[Home Lab Project]], emphasizing alignment with enterprise best practices, security, and learning objectives.

---

## 1. Firewall Operating System

*   **Chosen OS:** [[05-software/opnsense.md|OPNsense]]
    *   **Alternatives Considered:** pfSense, Linux `iptables`/`nftables` on general-purpose Linux.
    *   **Justification:**
        *   **Open Source:** Aligns with learning goals and provides transparency.
        *   **Enterprise-Grade Features:** Offers robust [[network-firewall-overview.md|firewalling]], [[llnotes/VPN.md|VPN]], [[llnotes/DHCP.md|DHCP]], [[llnotes/DNS.md|DNS]], [[llnotes/QoS-(Quality-of-Service).md|QoS]], and [[Intrusion Detection System (IDS)|IDS/IPS]] capabilities.
        *   **Modern UI & API:** User-friendly web GUI and a powerful API for [[llnotes/Automation|automation]].
        *   **Active Development & Community:** Strong focus on security and frequent updates.
        *   **Underlying OS:** Based on [[llnotes/FreeBSD.md|FreeBSD]], known for its stable and performant network stack.

## 2. Kubernetes Host Operating System

*   **Chosen OS:** [[04-platform/kubernetes_distro.md#Talos Linux|Talos Linux]]
    *   **Alternatives Considered:** [[llnotes/Ubuntu Server LTS.md|Ubuntu Server LTS]], [[llnotes/Rocky Linux.md|Rocky Linux]].
    *   **Justification:**
        *   **[[Immutable Infrastructure.md|Immutable Design]]:** Enhances [[Network Security|security]] and reliability by preventing configuration drift and direct host modification ([[no SSH]]).
        *   **Minimal Footprint:** Contains only essential components for [[Kubernetes]], reducing [[llnotes/Reduced-Attack-Surface.md|attack surface]] and overhead.
        *   **API-Driven Management:** Forces learning of [[llnotes/Talos-API.md|API-driven management]] via `talosctl`, a crucial [[cloud-native]] skill.
        *   **Kubernetes-Specific:** Purpose-built for [[Kubernetes]], ensuring optimal integration.
        *   **Security:** High security posture is a primary design goal.

## 3. Kubernetes Distribution

*   **Chosen Distribution:** [[04-platform/kubernetes_distro.md#K3s Kubernetes Distribution|K3s]] (or Talos Kubernetes if exclusively using Talos OS tools).
    *   **Alternatives Considered:** Kubeadm, MicroK8s, RKE.
    *   **Justification:**
        *   **Lightweight:** Ideal for a [[Home Lab Project|home lab]] due to its minimal resource footprint, allowing more nodes on limited hardware.
        *   **Certified Kubernetes:** Full API compatibility with standard [[Kubernetes]].
        *   **Ease of Installation:** Simplifies initial cluster deployment.
        *   **Integrated Components:** Includes [[llnotes/Containerd.md|containerd]] as its default [[Container Runtime Interface (CRI).md|CRI]], reducing complexity.

## 4. NAS Operating System

*   **Chosen OS:** [[05-software/truenas_scale.md|TrueNAS SCALE]]
    *   **Alternatives Considered:** OpenMediaVault, FreeNAS (legacy).
    *   **Justification:**
        *   **[[llnotes/ZFS.md|ZFS]] Foundation:** Provides enterprise-grade [[llnotes/Data-Integrity.md|data integrity]], [[llnotes/ZFS-Snapshots.md|snapshots]], and [[llnotes/RAID.md|RAID-like]] capabilities for [[Archival Media Storage.md|bulk media storage]].
        *   **Linux-Based:** TrueNAS SCALE is Linux-based, offering flexibility for containers and VMs.
        *   **Feature-Rich:** Robust [[File Sharing|file sharing]] protocols ([[llnotes/SMB-(Server-Message-Block).md|SMB]], [[llnotes/NFS-(Network-File-System).md|NFS]]).
        *   **Active Community & Development:** Strong support and continuous improvement.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[02-decisions/README.md|Decisions Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]
