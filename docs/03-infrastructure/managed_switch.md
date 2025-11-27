# Managed Switch Details

## Primary Managed Switch (1 Node - New Purchase)

*   **Model:** D-Link DGS-1210-16 (or similar D-Link DGS-1210 series 16/24-port)
*   **Type:** Smart Managed Gigabit Ethernet Switch
*   **Ports:** 16x 1GbE RJ-45 ports
    *   **Justification:** Sufficient port count for initial [[LAN_K8S]] segment (8 K8s nodes, 1 Management PC, 1 NAS, 1 Uplink to Firewall).
*   **Power:** Fanless, low power consumption.
    *   **Justification:** Aligns with [[01-overview/goals.md#Non-Functional Requirements|low noise and energy efficiency]] goals for the [[Home Lab Project]].
*   **Key Features:**
    *   [[llnotes/VLANs.md|802.1Q VLAN]] support (essential for [[Network Segmentation]]).
    *   [[llnotes/Link-Aggregation-(LACP).md|Link Aggregation (LACP)]].
    *   [[llnotes/QoS-(Quality-of-Service).md|QoS]].
    *   [[llnotes/Port-Mirroring.md|Port Mirroring]].
    *   [[Network Security|Basic security features]] (e.g., port security).
*   **Justification:** Cost-effective, silent, energy-efficient, and provides essential managed features. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].

## Future Secondary PoE Managed Switch (Optional Future Purchase)

*   **Model:** [e.g., Netgear GS308P, TP-Link TL-SG108PE, or similar 8/16-port fanless PoE+ Managed Switch]
*   **Type:** PoE+ Managed Gigabit Ethernet Switch
*   **Ports:** 8-16x 1GbE RJ-45 ports (all or some with [[llnotes/PoE-(Power-over-Ethernet).md|PoE+]]).
*   **Justification:** Dedicated power and data for [[llnotes/Security Cameras.md|security cameras]] and [[llnotes/IoT Devices.md|IoT Devices]], supporting the [[LAN_IOT_CAM]] segment. This will be added when the [[LAN_IOT_CAM]] segment is built. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].

## Role in Architecture

Managed switches are critical for:
*   Implementing [[Network Segmentation|logical network segmentation]] using [[llnotes/VLANs.md|VLANs]] (e.g., [[VLAN 10.10 - K8s Nodes]], [[VLAN 10.20 - Management]]).
*   Providing dedicated [[llnotes/Access-Ports.md|access ports]] for different device types (K8s nodes, [[llnotes/Management-PC.md|Management PC]], [[llnotes/NAS-Server.md|TrueNAS server]]).
*   Creating [[llnotes/Trunk-Ports.md|trunk ports]] to the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]] to carry multiple VLANs.
*   Improving [[Network Security]] by controlling traffic flow between segments.

