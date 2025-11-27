# Firewall PC Details

## Hardware Specifications

*   **Model:** HP EliteDesk G3 SFF (Small Form Factor)
*   **CPU:** Intel Core i5-6500 (4 cores, 4 threads, 3.2GHz base, 3.6GHz turbo, 65W TDP)
    *   **Features:** Supports [[llnotes/AES-NI.md|AES-NI]] (critical for [[llnotes/VPN.md|VPN]]/[[Data Encryption|encryption]]).
    *   **Justification:** Chosen for its superior [[PCIe]] expansion for a reliable NIC and robust platform. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
*   **RAM:** 8GB DDR4 (2x4GB configuration at 2400MHz)
    *   **Justification:** Sufficient for [[05-software/opnsense.md|OPNsense]] and planned services (IDS/IPS, VPN, HAProxy). Future upgrade to 16GB (2x8GB) if [[08-operations/monitoring_alerts.md|monitoring]] indicates need.
*   **Storage:** 120GB SATA SSD
    *   **File System:** [[llnotes/ZFS.md|ZFS]] (Stripe - No Redundancy)
    *   **Justification:** Fast boot, responsive GUI, ample space for OPNsense OS, packages, and logs. Not used for [[07-storage/ceph_cluster_design.md|Ceph]] or [[08-operations/backup_recovery.md|general backups]] to maintain [[llnotes/Reduced-Attack-Surface.md|reduced attack surface]].
*   **Network Interface Card (NIC):** Intel I350-T4 (4x 1GbE RJ-45) + 1x Onboard 1GbE NIC = **5 total ports**
    *   **PCIe Slot:** Intel I350-T4 installed in the X16PCIEXP slot.
    *   **Why Chosen:** [[llnotes/Intel-I350-T4-NIC.md|Server-grade reliability]], excellent [[05-software/opnsense.md|OPNsense]] driver support, 5 physical ports for granular [[Network Segmentation|network segmentation]]. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
*   **Power Supply Unit (PSU):** [e.g., 200W or 240W, typical for SFF]

## Software

*   **Operating System:** [[05-software/opnsense.md|OPNsense]] [Version Number, e.g., 24.1.x] (bare-metal installation on ZFS).

## Role in Architecture

The Firewall PC acts as the **primary perimeter defense** for the entire [[Home Lab Project|home network]] and [[llnotes/Kubernetes-cluster.md|Kubernetes lab]]. It performs:
*   Main [[llnotes/Router.md|Router]]: Handles all WAN/LAN routing and [[llnotes/Network-Address-Translation-NAT.md|NAT]].
*   [[llnotes/DHCP.md|DHCP Server]]: Provides DHCP for all [[06-network/ip_addressing_scheme.md|internal network segments]].
*   [[llnotes/DNS.md|DNS Resolver]]: Provides DNS resolution and [[llnotes/Reserved-IP-Addresses.md|host overrides]] for the entire lab.
*   [[Network Firewall Overview|Firewall]]: Enforces [[06-network/opnsense_firewall_rules.md|firewall rules]] between all segments and to/from the [[Internet]].
*   [[06-network/vpn_setup.md|VPN Server]] (Future): Secure remote access.
*   [[05-software/reverse_proxy.md|Reverse Proxy]] (Future): HAProxy for lab services.
*   [[06-network/opnsense_firewall_rules.md#Intrusion Detection and Prevention (IDS/IPS)|IDS/IPS]] (Future): Traffic inspection.

## BIOS/UEFI Configuration Log (for Intel I350-T4 NIC & OPNsense)

This section documents the specific [[BIOS and UEFI Fundamentals.md|BIOS/UEFI]] changes required to enable the [[llnotes/Intel-I350-T4-NIC.md|Intel I350-T4 NIC]] and allow [[05-software/opnsense.md|OPNsense]] to boot. This was a critical [[08-operations/troubleshooting.md|troubleshooting]] step.

**Problem:** HP [[llnotes/HP-BIOS-SureStart.md|BIOS SureStart]] and [[llnotes/Secure-Boot.md|Secure Boot]] blocked system boot with the new PCIe NIC.

**Resolution Steps:**

1.  **Preparation:** Remove NIC from PC. Boot to BIOS (F10).
2.  **`Security` Menu Changes:**
    *   `BIOS SureStart`:
        *   Unticked: `Dynamic Runtime Scanning of Boot Block`
        *   Unticked: `Enhanced HP Firmware Runtime Intrusion Prevention and Detection`
    *   `[[llnotes/TPM-Embedded-Security.md|TPM Embedded Security]]`: Set to `Disabled`
    *   `Intel Software Guard Extensions (SGX)`: Set to `Disabled`
3.  **`Advanced > Secure Boot Configuration`:**
    *   `Configure legacy support and secure boot`: Selected `Legacy support disable and secure boot disable`
4.  **`Advanced > Boot Options`:**
    *   `Fast Boot` or `Quick Boot`: Set to `Disabled` (if present)
    *   `USB Storage Boot`: Confirmed `Ticked (enabled)`
5.  **Save & Exit BIOS.**
6.  **Physical Installation:** Power off, install [[llnotes/Intel-I350-T4-NIC.md|Intel I350-T4 NIC]] in X16PCIEXP slot.
7.  **Boot Verification:** PC successfully booted to OS selection/no boot device found.
8.  **OPNsense Boot:** Insert OPNsense USB. Used F9 Boot Menu to select USB drive. Successfully initiated [[llnotes/OPNsense-OS-Installation.md|OPNsense installation]].

*(Include screenshots of key BIOS settings here if possible)*

---

## Related Links
- [[03-infrastructure/README.md|Infrastructure Overview]]
- [[02-decisions/hardware_selection.md|Hardware Selection Justification]]
- [[llnotes/Intel-I350-T4-NIC.md|Intel I350-T4 NIC Details]]
- [[BIOS and UEFI Fundamentals.md]]
- [[learning/OPNsense-Full-Install-Walkthrough.md|OPNsense Full Install Walkthrough]]
