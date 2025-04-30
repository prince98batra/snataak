## **REDIS INSTALLATION POC**

<p align="center">
  <img src="https://raw.githubusercontent.com/github/explore/main/topics/redis/redis.png" alt="Redis Logo" width="200"/>
</p>

## **Author Information**
| Created     | Last updated | Version | Author         | Level | Reviewer |
|-------------|--------------|---------|----------------|-------|----------|
| 25-04-2025  | 25-04-2025  | V1     | Prince Batra   | Internal Review | Siddharth Pawar |
| 25-04-2025  | 25-04-2025   | V2      | Prince Batra   | L0 Review        | Shikha |
| 25-04-2025  | 25-04-2025 |  V3    | Prince Batra  |     L1 Review    | Kirti Nehra   |


## Table of Contents

- [Introduction](#introduction)  
- [Prerequisites](#prerequisites)
- [System Requirements](#system-requirements)  
- [Important Ports](#important-ports)  
- [Steps to Install](#steps-to-install)  
  - [1. Install Redis Server](#1-install-redis-server)  
  - [2. Enable Redis on Startup](#2-enable-redis-on-startup)  
  - [3. Start Redis Service](#3-start-redis-service)  
  - [4. Test Redis Connection](#4-test-redis-connection)  
  - [5. Basic Redis Configuration & Security Setup](#5-basic-redis-configuration-and-security-setup)
  - [6. Connect to Redis with Password Authentication](#6-connect-to-redis-with-password-authentication)    
- [Conclusion](#conclusion)  
- [Contact Information](#contact-information)  
- [Reference Table](#reference-table)  

---

## **Introduction**

This document outlines the evaluation and setup process for Redis, a high-performance in-memory data store. It is intended for teams or individuals assessing Redis for use in proof-of-concept (POC) applications that require fast, temporary data handling, such as caching, message brokering, or session management.

---

## **Prerequisites**

| Requirement    | Description                             |
|----------------|-----------------------------------------|
| OS/Platform    | Ubuntu 20.04 or later                   |
| Redis Version  | Latest stable version of Redis          |

---

## **System Requirements**

| **Requirement**           | **Recommended (Single Redis Node Setup)**                   |
|---------------------------|-------------------------------------------------------------|
| **Processor** | Dual-Core                  |
| **RAM**                    | **4 GB** (Minimum to ensure stable performance)             |
| **Disk Space (ROM)**       | **10 GB** (Sufficient for Redis binaries, logs, and RDB/AOF files) |
| **Operating System**       | **Ubuntu 22.04 LTS** (Preferred) / Any modern Linux distro  |

---

## **Important Ports**

| **Port** | **Description**                                                           |
|----------|----------------------------------------------------------------------------|
| 6379     | Default port used by Redis for client connections.                         |
| 26379    | Port used by Redis Sentinel for high availability and failover monitoring. |

---

## **Steps to Install**

### **1. Install Redis Server**

 #### System Update Command
>  **Follow Step 3 here**: [System Update Command](https://github.com/snaatak-Downtime-Crew/Documentation/tree/main/common_stack/operating_system/ubuntu/sop/commoncommands)

![image](https://github.com/user-attachments/assets/252e9fb7-1739-45f3-9ceb-2b62c031a40a)

 #### Software installation Command

>  **Follow Step 3 here**: [Install a software](https://github.com/snaatak-Downtime-Crew/Documentation/blob/main/common_stack/operating_system/ubuntu/sop/softwaremanagement/README.MD#3-Install-a-Software)

Use package-name as **redis-server**

![image](https://github.com/user-attachments/assets/45285562-ccf3-4785-b248-ebd76664e696)

### **2. Enable Redis on Startup**

>  **Follow Step 5 here**: [Enable a service](https://github.com/snaatak-Downtime-Crew/Documentation/blob/main/common_stack/operating_system/ubuntu/sop/services/README.md#systemctl-commands-explained)

**Use Service name as "redis-server"**

![image](https://github.com/user-attachments/assets/6a73380b-2bf8-42ff-ac5f-c709b07c1bce)

### **3. Start Redis Service**

>  **Follow Step 1 here**: [Start a service](https://github.com/snaatak-Downtime-Crew/Documentation/blob/main/common_stack/operating_system/ubuntu/sop/services/README.md#systemctl-commands-explained)

**Use Service name as "redis-server"**

![image](https://github.com/user-attachments/assets/546a9956-745b-4d20-b01b-5559f23ac384)

### **4. Test Redis Connection**

Verify Redis is running by using the Redis CLI:

```bash
redis-cli ping
```

![image](https://github.com/user-attachments/assets/3e454a70-e470-44e5-844e-c15a9dcb2d46)

### **5. Basic Redis Configuration And Security Setup**

1. **Open the Redis Configuration File:**
   To configure Redis, open the `redis.conf` file located in `/etc/redis/redis.conf`:

   > **Follow Step 2 from here**: [Open the configuration file](https://github.com/snaatak-Downtime-Crew/Documentation/blob/main/common_stack/operating_system/ubuntu/sop/commoncommands/README.md#2-file-commands)

**Use filename as "/etc/redis/redis.conf"**

![image](https://github.com/user-attachments/assets/cb6381ad-9ca4-440f-ae64-71dbc8d233ba)


2. **Configure Redis Authentication:**
   To secure your Redis instance with a password, uncomment and set the `requirepass` directive to your desired password:

   ```plaintext
   requirepass YourStrongPassword
   ```

   This ensures that only clients who know the password can interact with Redis.
   
![image](https://github.com/user-attachments/assets/145ac4e7-cee8-43a2-b526-9bdd00111484)

3. **Restart Redis Service:**
   To apply the changes, restart the Redis server:

   >  **Follow Step 3 here**: [Restart a service](https://github.com/snaatak-Downtime-Crew/Documentation/blob/main/common_stack/operating_system/ubuntu/sop/services/README.md#systemctl-commands-explained)

**Use Service name as "redis-server"**

![image](https://github.com/user-attachments/assets/19036910-70ef-4074-9650-734c2009cee9)

### **6. Connect to Redis with Password Authentication**

Open Redis CLI, authenticate with the password, and test the connection using the ping command

```bash
redis-cli
auth YourStrongPassword
ping
```

![image](https://github.com/user-attachments/assets/9459321d-1472-4d7d-9777-1a502a8aac67)

---

## **Conclusion**

Redis is a high-performance, in-memory key-value store, ideal for POC projects that require caching, messaging, or queuing. While it is simple to install and configure, advanced configuration such as authentication and ACL setup should be considered to secure your Redis instance, especially for production or multi-user environments.

---

## **Contact Information**

| Name           | Email Address                             |
|----------------|-------------------------------------------|
| Prince Batra   | prince.batra.snaatak@mygurukulam.co       |

---

## **Reference Table**

| **Title**           | **Link**                                     | **Description**                              |
|---------------------|----------------------------------------------|----------------------------------------------|
| Redis Official Site | [https://redis.io](https://redis.io)          | Official website with documentation and guides |
| Redis GitHub Repo   | [https://github.com/redis/redis](https://github.com/redis/redis) | Source code and release updates              |
| RedisInsight        | [https://www.redis.com/redis-enterprise/redis-insight](https://www.redis.com/redis-enterprise/redis-insight) | GUI tool for visualizing and debugging Redis  |
