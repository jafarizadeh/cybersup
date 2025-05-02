## Project Description

This project involves setting up a complete network infrastructure with 3 switches and 1 Cisco 1941 router, following these requirements:

* 4 VLANs (VoIP, WiFi, Fixed PC, Admin)
* 3 Switches (SW-Core, SW2, SW3)
* A router handling DHCP, inter-VLAN routing, and acting as the gateway
* Precise port assignments (trunk & access)
* Intra- and inter-VLAN connectivity tests

---

## Network Topology

```
[ Laptop ]~~>Access Point---+
                            |
                            |       +-------------+
[ PC / IP Phone ]-----------+--SWx--|  SW-Core    |--Router (G0/0)
                                    +-------------+
                                          |
                                       VLAN Trunk
```

---

## 🖧 VLANs

| VLAN ID | Name     | Description            |
| ------- | -------- | ---------------------- |
| 1       | VoIP     | IP Phones              |
| 10      | WiFi     | Wireless Access Points |
| 20      | PC\_Fixe | Workstations           |
| 30      | Admin    | Network Administration |

---

## Key Configuration

### Cisco 1941 Router (GigabitEthernet0/0)

* Created `subinterfaces`: `.1`, `.10`, `.20`, `.30`
* `dot1Q encapsulation` for each VLAN
* `ip dhcp pool` for each VLAN (DNS: 8.8.8.8)
* IP addresses:

  * VLAN1: 192.168.0.1
  * VLAN10: 192.168.10.1
  * VLAN20: 192.168.20.1
  * VLAN30: 192.168.30.1

### DHCP

| VLAN   | DHCP Range      | Exclusions        |
| ------ | --------------- | ----------------- |
| VLAN1  | 192.168.0.0/24  | 192.168.0.1–0.3   |
| VLAN10 | 192.168.10.0/24 | 192.168.10.1–10.3 |
| VLAN20 | 192.168.20.0/24 | 192.168.20.1–20.3 |
| VLAN30 | 192.168.30.0/24 | 192.168.30.1–30.3 |

---

## Switch Configuration

### SW-Core

* Ports `Fa0/1`, `Fa0/2`, `Fa0/3`, `Gi0/1` → `trunk`
* VLAN assignments:

  * `Fa0/4-5` → VLAN10 (WiFi)
  * `Fa0/6-7` → VLAN20 (Fixed PCs)
  * `Fa0/8` → VLAN30 (Admin)
  * `Fa0/9+` → VLAN1 (VoIP)

### SW2 & SW3

* Trunk to SW-Core (port `Fa0/1`)
* Access ports to end-users (assigned to the appropriate VLANs)

---

## Tests Performed

* ✅ PC in each VLAN receives an IP via DHCP
* ✅ Successful PING between VLANs (inter-VLAN routing operational)
* ✅ Successful PING from each machine to the router
* 🔄 Internet access (NAT) ready to be configured if necessary

---

## Final Recommendations

* All trunk ports use `802.1Q`
* Inter-VLAN routing works through a single trunk interface
* The design is modular and scalable (easy to integrate into a larger network)
* Well-documented for oral presentation or GitHub submission
