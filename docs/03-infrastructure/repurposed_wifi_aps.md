# Repurposed Wi-Fi Access Points (APs)

## Overview

To maintain existing [[llnotes/Wi-Fi.md|Wi-Fi]] coverage across the home without incurring additional costs or running new cables, two existing [[llnotes/Wireless-Router.md|wireless routers]] have been repurposed as dedicated [[Wireless Access Point (AP)|Wi-Fi Access Points]] and extenders. This leverages existing hardware while ensuring the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]] is the sole [[llnotes/Router.md|router]] and [[llnotes/DHCP.md|DHCP server]].

## 1. Repurposed Main Router (Downstairs AP)

*   **Original Model:** [e.g., TP-Link Archer C60]
*   **Original Role:** Primary home router.
*   **New Role:** Dedicated [[Wireless Access Point (AP)|Wi-Fi Access Point (AP)]] for the downstairs area.
*   **Connection:** Connects via Ethernet from one of its **LAN ports** (NOT WAN) to the `igb3/LAN_HOME_WIFI` port on the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]].
*   **Configuration:**
    *   **DHCP Server:** **DISABLED.**
    *   **LAN IP Address:** Set to a static [[IP Addressing|IP address]] within the [[06-network/ip_addressing_scheme.md#LAN_HOME_WIFI Network Segment|LAN_HOME_WIFI subnet]] (e.g., `192.168.30.250`).
    *   **Routing/NAT:** **DISABLED.** Operates in "AP mode" or as a pure switch/AP.
    *   **Wi-Fi Settings:** Existing SSIDs and passwords retained for seamless transition.

## 2. Repurposed Second Router (Upstairs Wi-Fi Extender)

*   **Original Model:** [e.g., Older TP-Link Router]
*   **Original Role:** Wireless extender/repeater for the main router.
*   **New Role:** Continues as a [[Wi-Fi Extender|Wi-Fi Extender/Repeater]] for the Downstairs AP.
*   **Connection:** Connects **wirelessly** to the Repurposed Main Router (Downstairs AP). No new Ethernet cable is run to this device.
*   **Configuration:**
    *   **DHCP Server:** **DISABLED** (or configured in Repeater mode to obtain IP from upstream).
    *   **LAN IP Address:** Set to a static [[IP Addressing|IP address]] within the [[06-network/ip_addressing_scheme.md#LAN_HOME_WIFI Network Segment|LAN_HOME_WIFI subnet]] (e.g., `192.168.30.251`), or obtains one from OPNsense DHCP.
    *   **Wi-Fi Settings:** Existing SSIDs and passwords retained.
*   **Wired Client Support:** Continues to provide wired connectivity via its LAN ports for old PCs on the second floor; these clients will receive [[IP Addressing|IP addresses]] from the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC's]] `LAN_HOME_WIFI` DHCP server.

## Role in Architecture

*   Provides comprehensive [[llnotes/Wi-Fi.md|Wi-Fi]] coverage across the home.
*   Integrates seamlessly with the [[03-infrastructure/firewall_pc.md|OPNsense Firewall PC]] as the central [[llnotes/Router.md|router]] without creating [[llnotes/Double-NAT.md|Double-NAT]].
*   Allows for [[Network Segmentation|isolation]] of general home [[llnotes/Wi-Fi.md|Wi-Fi]] traffic via a dedicated physical interface on the firewall.

