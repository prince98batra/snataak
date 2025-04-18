
# Ansible Dynamic Inventory

## 👤 Author

| Created       | Version | Last Modified | Author        | Level          | Reviewer         |
|---------------|---------|---------------|---------------|----------------|------------------|
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | Internal Review| Siddharth Pawar  |
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | L0 Review      | Shikha           |

---

## Table of Contents

1. [Introduction](#introduction)  
2. [Why Use Dynamic Inventory in Ansible?](#why-use-dynamic-inventory-in-ansible)  
3. [Advantages vs Disadvantages](#advantages-vs-disadvantages)  
4. [Best Practices](#best-practices)  
5. [Flow Diagram](#flow-diagram)  
6. [Installing & Configuring Dynamic Inventory](#installing--configuring-dynamic-inventory-for-cloud-computing-aws)  
7. [Using Dynamic Inventory in Real Projects](#using-dynamic-inventory-in-real-projects)  
8. [Conclusion / Recommendation](#conclusion--recommendation)  
9. [Contact Information](#contact-information)  
10. [References](#references)

---

## Introduction

To provide a step-by-step SOP for setting up and using Ansible’s dynamic inventory with AWS EC2. It explains how to fetch hostnames, IPs, and tags in real time and optionally combine it with a database or metadata server.

---

## Why Use Dynamic Inventory in Ansible?

- Automatically reflects real-time infrastructure changes.  
- No need to hardcode or manually update IP addresses.  
- Helps organize hosts by EC2 tags (e.g., `Name`, `Environment`).  
- Supports multiple sources: AWS, databases, or custom scripts.  
- Ideal for managing auto-scaled or frequently changing environments.

---

## Advantages vs Disadvantages

| Advantages                               | Disadvantages                          |
|-----------------------------------------|----------------------------------------|
| Auto-updates inventory on EC2 changes   | Slightly more complex setup            |
| Easy filtering using EC2 tags           | Needs AWS credentials or IAM role      |
| No static IPs or manual host lists      | Debugging can be less straightforward  |
| Can be combined with other data sources | Plugin configuration must be maintained|

---

## Best Practices

- Use EC2 **Name** and **Environment** tags to group servers logically.  
- Store inventory YAML files in a separate `inventory/` folder.  
- Use `compose:` to map EC2 fields like public/private IPs to `ansible_host`.  
- Test inventory output using `ansible-inventory --list`.  
- Use `ansible-inventory --graph` to visualize host groups.  
- Cache results for large inventories using `cache: true`.

---

## Flow Diagram

```
        [ AWS EC2 Instances ]
                ↓
    [ Ansible aws_ec2 Plugin ]
                ↓
      [ aws_ec2.yml Inventory ]
                ↓
  [ Optional: DB + Custom Script ]
                ↓
      [ Final Inventory Output ]
                ↓
       [ Ansible Playbook ]
```

---

## Installing & Configuring Dynamic Inventory For Cloud Computing (AWS)

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
![image](https://github.com/user-attachments/assets/28ada497-b7dd-44d7-ae71-b65bd6aaf3de)

This sets:
- AWS Access Key
- AWS Secret Key
- Region (e.g., `ap-south-1`)
- Output format (`json`)

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
- Public/private IPs
- Grouping by tags like `tag_Name_webserver`

![image](https://github.com/user-attachments/assets/0b3350ba-7536-4505-9b86-549fe539a42a)

---

## Using Dynamic Inventory in Real Projects

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

### Use Database Inventory (Advanced)

You can write a **custom Python script** to query a database (like PostgreSQL) that holds metadata for hosts. Ansible supports executable inventory scripts.


        [ SQLite Database ]
                ↓
   [ Python Script to Query Database ]
                ↓
   [ Dynamic Inventory Script (Python) ]
                ↓
      [ Final Inventory Output (JSON) ]
                ↓
       [ Ansible Playbook Execution ]


---

## Conclusion / Recommendation

Dynamic Inventory in Ansible helps manage cloud infrastructure in real-time by pulling host information directly from AWS. It replaces static IP-based inventories and improves automation, tagging, and scalability. Use optional database sources only if your setup includes metadata outside AWS.

---

## Contact Information

**Author**: Prince Batra  
**Email**: prince98batra@gmail.com  
**GitHub**: [github.com/prince98batra](https://github.com/prince98batra)

---

## References

| Reference                               | Link                                                                 |
|-----------------------------------------|----------------------------------------------------------------------|
| AWS EC2 Inventory Plugin                | https://docs.ansible.com/ansible/latest/plugins/inventory/aws_ec2.html |
| Ansible Inventory User Guide            | https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html |
| Custom Inventory Script Dev Guide       | https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html |
| AWS IAM Role for EC2 Dynamic Access     | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html |
```

---

Let me know if you'd like it in `.docx`, `.pdf`, or any format for sharing/submitting.
