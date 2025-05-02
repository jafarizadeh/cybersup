
# MSc Cybersecurity - Admission Project

Welcome! This repository includes the work completed as part of the admission test for the MSc Cybersecurity program at **Cybersup**. The test consisted of three hands-on technical exercises covering **networking**, **system administration**, and **containerization/devops**.

---

##  Project Overview

1. [Exercise 1 - Packet Tracer (Networking & VLANs)](#exercise-1---packet-tracer)
2. [Exercise 2 - Active Directory (Windows Server + PowerShell)](#exercise-2---active-directory)
3. [Exercise 3 - Docker & WordPress Deployment](#exercise-3---docker--wordpress-deployment)

Each task includes:
-  Configuration files / source code
-  Screenshots
-  Technical documentation

---

## Exercise 1 - Packet Tracer

 **Objective**: Build a small enterprise network using:
- 1 Cisco 1941 Router
- 3 switches
- 3 Wi-Fi access points
- 6 desktop PCs, 3 laptops
- 3 Cisco IP phones

 **Key Elements**:
- 4 VLANs configured: `VLAN 1 (VoIP)`, `VLAN 10 (WiFi)`, `VLAN 20 (Fixed PCs)`, `VLAN 30 (Admin)`
- Router configured to handle:
  - Inter-VLAN routing
  - DHCP server for all VLANs
  - Internet gateway
- Validation:
  -  DHCP IP address distribution
  -  Inter-VLAN communication
  -  Successful ping to and from router interfaces

 **GitHub Folder**:
- Packet Tracer `.pkt` file
- Device configuration exports
- Screenshots and explanations → `/exercise1/`

---

## Exercise 2 - Active Directory

 **Objective**: Deploy a full-featured Active Directory service with domain `laplateforme.io` using PowerShell on Windows Server.

 **Details**:
- 15 users and 9 organizational groups imported via `.csv`
- Users can belong to multiple groups
- Default password: `Azerty2025!` (mandatory change at first login)
- Strong password policy enforced

 **Included Scripts**:
- `AD-Setup.ps1`: Installs AD DS role and promotes server to Domain Controller
- `Create-UsersFromCSV.ps1`: Automates user and group creation from CSV file

 **GitHub Folder**:
- PowerShell scripts + sample CSV
- Screenshots and setup guide → `/exercise2/`

---

## Exercise 3 - Docker & WordPress Deployment

 **Objective**: Deploy a WordPress site using Docker Compose with the following services:
- `nginx`: Web server
- `php-fpm`: PHP processor
- `mariadb`: Database
- `wordpress`: CMS

 **Volumes Used**:
- Persistent storage for database, WordPress content, and nginx configuration

 **Access the site locally**:
```bash
http://localhost:8080
```

 **GitHub Folder**:
- `docker-compose.yaml`
- `nginx.conf`
- Screenshots and installation instructions → `/exercise3/`

---

## Additional Link

-  Full GitHub repository: *https://github.com/jafarizadeh/cybersup.git*

---

## Conclusion

This project showcases technical skills across:
- Networking (Cisco devices, VLAN, routing, DHCP)
- System administration (Windows Server, Active Directory, PowerShell automation)
- DevOps (Docker, Nginx, CMS deployment)

Please feel free to explore each exercise folder for detailed information and screenshots.

---

📄 **Prepared by**: *Mehdi JAFARIZADEH*  
🎓 **Applicant for MSc Cybersecurity - Cybersup**
