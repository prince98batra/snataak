<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/1664px-Ansible_logo.svg.png" alt="Ansible Logo" width="200"/>
</p>

# Ansible Dynamic Inventory

## 👤 Author

| Created       | Version | Last Modified | Author        | Level          | Reviewer         |
|---------------|---------|---------------|---------------|----------------|------------------|
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | Internal Review| Siddharth Pawar  |
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | L0 Review      | Shikha           |

---

## Table of Contents

1. [Introduction](#1-introduction)  
2. [Why Use Dynamic Inventory in Ansible?](#2-why-use-dynamic-inventory-in-ansible)  
3. [Advantages vs Disadvantages](#3-advantages-vs-disadvantages)  
4. [Best Practices](#4-best-practices)  
5. [Flow Diagram](#5-flow-diagram)  
6. [Installing & Configuring Dynamic Inventory](#6-installing--configuring-dynamic-inventory-for-cloud-computing-aws)  
7. [Using Dynamic Inventory in Real Projects](#7-using-dynamic-inventory-in-real-projects)  
8. [How Database-Based Dynamic Inventory Works](#8-how-database-based-dynamic-inventory-works)  
9. [Conclusion](#9-conclusion)  
10. [Contact Information](#contact-information)  
11. [Reference Table](#reference-table)

---

## 1. Introduction

To provide a step-by-step SOP for setting up and using Ansible’s dynamic inventory with AWS EC2. It explains how to fetch hostnames, IPs, and tags in real time and optionally combine it with a database or metadata server.

---

## 2. Why Use Dynamic Inventory in Ansible?

- Automatically reflects real-time infrastructure changes.  
- No need to hardcode or manually update IP addresses.  
- Helps organize hosts by EC2 tags (e.g., `Name`, `Environment`).  
- Supports multiple sources: AWS, databases, or custom scripts.  
- Ideal for managing auto-scaled or frequently changing environments.

---

## 3. Advantages vs Disadvantages

| Advantages                               | Disadvantages                          |
|-----------------------------------------|----------------------------------------|
| Auto-updates inventory on EC2 changes   | Slightly more complex setup            |
| Easy filtering using EC2 tags           | Needs AWS credentials or IAM role      |
| No static IPs or manual host lists      | Debugging can be less straightforward  |
| Can be combined with other data sources | Plugin configuration must be maintained|

---

## 4. Best Practices

- Use EC2 **Name** and **Environment** tags to group servers logically.  
- Store inventory YAML files in a separate `inventory/` folder.  
- Use `compose:` to map EC2 fields like public/private IPs to `ansible_host`.  
- Test inventory output using `ansible-inventory --list`.  
- Use `ansible-inventory --graph` to visualize host groups.  
- Cache results for large inventories using `cache: true`.

---

## 5. Flow Diagram

```
[ Install amazon.aws Plugin ]
             ↓
[ Configure AWS Credentials ]
             ↓
[ Create aws_ec2.yml Inventory File ]
             ↓
[ Run ansible-inventory --list ]
             ↓
[ Get EC2 Hosts by Tag/Public IP ]
             ↓
[ Run Playbook on Dynamic Inventory ]
```

---

## 6. Installing & Configuring Dynamic Inventory For Cloud Computing (AWS)

### 🔹 Step 1: Install Required Plugin
Install the AWS dynamic inventory plugin from Ansible Galaxy:
```bash
ansible-galaxy collection install amazon.aws
```
![image](https://github.com/user-attachments/assets/54fe43ae-af21-425e-87d5-6cca130cc841)

### 🔹 Step 2: Configure AWS Access
Run the AWS CLI configuration and enter your credentials:
```bash
aws configure
```
This sets:
- AWS Access Key  
- AWS Secret Key  
- Region (e.g., `ap-south-1`)  
- Output format (`json`)  

![image](https://github.com/user-attachments/assets/28ada497-b7dd-44d7-ae71-b65bd6aaf3de)

### 🔹 Step 3: Create `aws_ec2.yml` Inventory File

Create a file at `inventory/aws_ec2.yml`:

```yaml
plugin: amazon.aws.aws_ec2
regions:
  - ap-northeast-1
filters:
  tag:Name: ansible-test
keyed_groups:
  - prefix: tag
    key: Tags.Name
hostnames:
  - tag:Name
compose:
  ansible_host: public_ip_address
```

![image](https://github.com/user-attachments/assets/b44f49c2-d4b8-4375-abd0-db6ab2e5b1a1)

### 🔹 Step 4: Test Inventory Output

Run this command to verify:
```bash
ansible-inventory -i inventory/aws_ec2.yml --list
```

This will return:
- EC2 instance names (from `tag:Name`)  
- Public IPs  

![image](https://github.com/user-attachments/assets/0b3350ba-7536-4505-9b86-549fe539a42a)

---

## 7. Using Dynamic Inventory in Real Projects

### Example Playbook

```yaml
- name: Deploy Web Server on EC2
  hosts: tag_Name_webserver
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

> This playbook targets all EC2s with tag `Name=webserver`, fetched dynamically.

---

## 8. How Database-Based Dynamic Inventory Works

1. **Server Info Storage**: Your team manually or automatically stores server data (like name, IP, tags) into a database — this can be synced from AWS, a CMDB, or entered manually.

2. **Python Script Logic**: A custom Python script connects to this database, runs a query (e.g., get all production servers), and fetches the necessary details.

3. **Format as JSON**: The script converts this data into Ansible-compatible JSON format and prints it to the console (stdout), which Ansible reads.

4. **Use as Inventory Source**: Mark the script as executable and use it directly in Ansible commands like:
```bash
ansible-inventory -i script.py --list
```

**Flow Diagram if Using Database for Custom Inventory**

```
[ Write Python Script for DB Query ]
             ↓
[ Convert Output to Ansible JSON Format ]
             ↓
[ Use Script as Executable Inventory ]
```

---

## 9. Conclusion

Dynamic Inventory in Ansible helps manage cloud infrastructure in real-time by pulling host information directly from AWS. It replaces static IP-based inventories and improves automation, tagging, and scalability. Use optional database sources only if your setup includes metadata outside AWS.

---

## Contact Information

| Name           | Email Address                             |
|----------------|-------------------------------------------|
| Prince Batra   | prince.batra.snaatak@mygurukulam.co       |

---

## Reference Table

| Reference                               | Link                                                                 |
|-----------------------------------------|----------------------------------------------------------------------|
| AWS EC2 Inventory Plugin                | https://docs.ansible.com/ansible/latest/plugins/inventory/aws_ec2.html |
| Ansible Inventory User Guide            | https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html |
| Custom Inventory Script Dev Guide       | https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html |
| AWS IAM Role for EC2 Dynamic Access     | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html |

--- 
