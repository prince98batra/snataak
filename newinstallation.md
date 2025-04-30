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
