# Software & Operating System Choices

This document details the rationale behind the primary software and operating system selections for the Home Lab Project, emphasizing alignment with enterprise best practices, security, and learning objectives.

---

## 1. Firewall Operating System

* **Chosen OS:** [[05-software/opnsense.md|OPNsense]]
  * **Alternatives Considered:** pfSense, Linux `iptables`/`nftables` on general-purpose Linux.
  * **Justification:**
    * **Open Source:** Aligns with learning goals and provides transparency.
    * **Enterprise-Grade Features:** Offers robust firewalling, VPN, DHCP, DNS, QoS, and IDS/IPS capabilities.
    * **Modern UI & API:** User-friendly web GUI and a powerful API for automation.
    * **Active Development & Community:** Strong support and continuous improvement.
    * **Underlying OS:** Based on FreeBSD, known for its stable and performant network stack.

## 2. Management Host Operating System

* **Chosen OS:** [[05-software/proxmox_ve.md|Proxmox Virtual Environment]]
  * **Alternatives Considered:** Ubuntu Server LTS (bare-metal), VMware ESXi.
  * **Justification:**
    * **Hypervisor Platform:** Provides a robust base for running multiple LXC containers (e.g., Omni, Prometheus, Grafana, Loki, AdGuard Home, HomePage) efficiently.
    * **Hyperconverged Capabilities:** Integrates virtualization and ZFS storage management.
    * **Centralized Management Plane:** Enables hosting critical infrastructure management components *outside* the managed Kubernetes cluster, improving resilience and observability.
    * **Open Source:** Aligns with learning goals.

## 3. Kubernetes Host Operating System

* **Chosen OS:** [[05-software/talos_linux.md|Talos Linux]]
  * **Alternatives Considered:** Ubuntu Server LTS, Rocky Linux.
  * **Justification:**
    * **Immutable Design:** Enhances security and reliability by preventing configuration drift and direct host modification (no SSH access).
    * **Minimal Footprint:** Contains only essential components for Kubernetes, reducing attack surface and overhead.
    * **API-Driven Management:** Forces learning of API-driven management via `talosctl`, a crucial cloud-native skill.
    * **Kubernetes-Specific:** Purpose-built for Kubernetes, ensuring optimal integration.
    * **Security:** High security posture is a primary design goal.

## 4. Kubernetes Distribution

* **Chosen Distribution:** Talos Kubernetes (the Kubernetes distribution bundled with [[05-software/talos_linux.md|Talos Linux]]).
  * **Alternatives Considered:** K3s, Kubeadm, MicroK8s, RKE.
  * **Justification:**
    * **Seamless Integration:** Fully optimized to run on [[05-software/talos_linux.md|Talos Linux]], simplifying deployment and management via [[05-software/omni.md|Omni]].
    * **Certified Kubernetes:** Full API compatibility with standard Kubernetes.
    * **Enhanced Security:** Benefits from the [[05-software/talos_linux.md|Talos Linux]] host OS's security features.
    * **Learning Value:** Provides experience with a specific, opinionated, and highly secure Kubernetes Distribution.

## 5. NAS Operating System

* **Chosen OS:** [[05-software/truenas_scale.md|TrueNAS SCALE]]
  * **Alternatives Considered:** OpenMediaVault, FreeNAS (legacy).
  * **Justification:**
    * **ZFS Foundation:** Provides enterprise-grade data integrity, snapshots, and RAID-like capabilities for bulk media storage.
    * **Linux-Based:** TrueNAS SCALE is Debian Linux-based, offering flexibility for containers and VMs.
    * **Feature-Rich:** Robust file sharing protocols (SMB, NFS).
    * **Active Community & Development:** Strong support and continuous improvement.

---

## Related Links
* [[01-overview/README.md|Project Overview]]
* [[02-decisions/README.md|Decisions Overview]]
* [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
* [[02-decisions/tradeoffs_compromises.md|Trade-offs & Compromises]]
