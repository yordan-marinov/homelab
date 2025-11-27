# Network Topology Decisions

This document details the reasoning behind the design of the [[Home Lab Project]]'s network topology, including physical connections, logical segmentation, and firewall placement, prioritizing [[Network Security]], [[Network Segmentation]], and [[llnotes/Availability.md|availability]].

---

## 1. Firewall Placement (Perimeter Defense)

*   **Decision:** Place the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]] directly behind the [[ISP Modem]], making it the central [[llnotes/Router.md|router]] for the entire home network.
*   **Justification:**
    *   **Eliminates [[llnotes/Double-NAT.md|Double-NAT]]:** Prevents connectivity issues, especially for [[llnotes/VPN.md|VPNs]] and external access to services.
    *   **Centralized Control:** The firewall becomes the single point of control for all [[Internet]] access, [[llnotes/DHCP.md|DHCP]], [[llnotes/DNS.md|DNS]], and [[06-network/opnsense_firewall_rules.md|firewall rules]], enhancing [[Network Security]].
    *   **Enterprise Mimicry:** Aligns with standard enterprise network architecture.

## 2. Multi-Interface Firewall (Physical Segmentation)

*   **Decision:** Utilize all 5 available Ethernet ports on the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]] (1 onboard, 4 from [[llnotes/Intel-I350-T4-NIC.md|Intel I350-T4 NIC]]) for distinct physical network segments.
*   **Justification:**
    *   **Maximum Isolation:** Each physical interface creates a strong boundary, enhancing [[Network Security]] by providing dedicated conduits for different trust zones.
    *   **Dedicated Bandwidth:** Prevents traffic contention between high-priority/high-volume segments (e.g., [[LAN_K8S]]) and other segments.
    *   **Clarity:** Clear mapping of network functions to physical ports.
*   **Interface Mapping (Example):**
    *   `igb0` (I350-T4 Port 1): WAN (ISP Modem)
    *   `igb1` (I350-T4 Port 2): [[LAN_K8S]] (to D-Link Managed Switch)
    *   `igb2` (I350-T4 Port 3): [[LAN_IOT_CAM]] (to Future PoE Managed Switch)
    *   `igb3` (I350-T4 Port 4): [[LAN_HOME_WIFI]] (to Repurposed Main Router AP)
    *   `em0` (Onboard Port): [[LAN_NAS]] (to TrueNAS Server)
    *   *Note: This specific mapping assumes `igb0-igb3` are the I350-T4 ports and `em0` is onboard. Actual assignments may vary but will follow this logic.*

## 3. VLAN-Based Network Segmentation (Logical Isolation)

*   **Decision:** Implement [[llnotes/VLANs.md|VLANs]] on the [[03-infrastructure/managed_switch.md|D-Link Managed Switch]] (connected to `LAN_K8S` interface) to further subdivide the Kubernetes/Management segment.
*   **Justification:**
    *   **Enhanced Security:** Logically separates critical [[04-platform/kubernetes_distro#Kubernetes Nodes|Kubernetes nodes]] from the [[llnotes/Management-VLAN.md|management PC]], limiting lateral movement in case of a breach.
    *   **Traffic Management:** Allows for targeted [[06-network/opnsense_firewall_rules.md|firewall rules]] between [[llnotes/VLANs.md|VLANs]] within the `LAN_K8S` segment.
    *   **Scalability:** Easier to add new logical segments without changing physical cabling.
*   **Planned VLANs (Example on `LAN_K8S`):**
    *   [[VLAN 10.10 - K8s Nodes]] (Kubernetes Masters and Workers)
    *   [[VLAN 10.20 - Management]] (Management PC)

## 4. Repurposing Existing Wi-Fi Infrastructure

*   **Decision:** Convert existing [[llnotes/Wireless-Router.md|wireless routers]] into [[llnotes/Wireless-Access-Point-AP.md|Access Points]] and connect them to the [[LAN_HOME_WIFI]] interface of the firewall.
*   **Justification:**
    *   **Maintain Coverage:** Preserves existing [[llnotes/Wi-Fi.md|Wi-Fi]] coverage across the home.
    *   **Cost-Effective:** Reuses existing hardware, avoiding new AP purchases.
    *   **Centralized Control:** Wi-Fi clients receive [[IP Addressing|IPs]] and [[llnotes/DNS.md|DNS]] from the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]], allowing for centralized [[llnotes/Content-Filtering.md|content filtering]] and [[Network Security|security enforcement]].
    *   **No Cabling Constraint:** The [[03-infrastructure/repurposed_wifi_aps.md#Repurposed Second Router (Upstairs Wi-Fi Extender)|upstairs extender]] can remain wirelessly connected.

---

## Related Links
- [[01-overview/README.md|Project Overview]]
- [[02-decisions/README.md|Decisions Overview]]
- [[06-network/physical_topology.md|Physical Network Topology Diagram]]
- [[06-network/logical_topology_vlans.md|Logical Network Diagram (VLANs)]]
- [[Network Security]]
- [[Network Segmentation]]
