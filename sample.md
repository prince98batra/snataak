Absolutely! Your updated flow is perfect — clean and easy to follow. I'll integrate this flow into the final SOP and restructure the content accordingly. Here's the **complete updated SOP** with:

- Correct TOC numbering  
- Your **new flow diagram**
- Combined **advantages/disadvantages** table  
- A new **Installation + Real Use** section mapped to the flow  
- Optional DB part clearly marked  

---

```markdown
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/1664px-Ansible_logo.svg.png" alt="Ansible Logo" width="200"/>
</p>

# Ansible Dynamic Inventory

## 👤 Author Information

| Created       | Version | Last Modified | Author        | Level          | Reviewer         |
|---------------|---------|---------------|---------------|----------------|------------------|
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | Internal Review| Siddharth Pawar  |
| 18-04-2025    | V1      | 18-04-2025    | Prince Batra  | L0 Review      | Shikha           |

---

## 📘 Table of Contents

1. [Purpose of the Document](#1-purpose-of-the-document)  
2. [Why Use Dynamic Inventory in Ansible?](#2-why-use-dynamic-inventory-in-ansible)  
3. [Advantages vs Disadvantages](#3-advantages-vs-disadvantages)  
4. [Best Practices](#4-best-practices)  
5. [Flow Diagram](#5-flow-diagram)  
6. [Installing & Configuring Dynamic Inventory](#6-installing--configuring-dynamic-inventory)  
7. [Using Dynamic Inventory in Real Projects](#7-using-dynamic-inventory-in-real-projects)  
8. [Conclusion / Recommendation](#8-conclusion--recommendation)  
9. [Contact Information](#9-contact-information)  
10. [References](#10-references)

---

## 1. Purpose of the Document

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

## 6. Installing & Configuring Dynamic Inventory

### 🔹 Step 1: Install Required Plugin
Install the AWS dynamic inventory plugin from Ansible Galaxy:
```bash
ansible-galaxy collection install amazon.aws
```

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

You can also use an **IAM Role** if Ansible runs from an EC2 instance.

### 🔹 Step 3: Create `aws_ec2.yml` Inventory File

Create a file at `inventory/aws_ec2.yml`:

```yaml
plugin: amazon.aws.aws_ec2
regions:
  - ap-south-1
filters:
  tag:Environment: production
keyed_groups:
  - prefix: tag
    key: Tags.Name
hostnames:
  - tag:Name
compose:
  ansible_host: public_ip_address
```

### 🔹 Step 4: Test Inventory Output

Run this command to verify:
```bash
ansible-inventory -i inventory/aws_ec2.yml --list
```

This will return:
- EC2 instance names (from `tag:Name`)
- Public/private IPs
- Grouping by tags like `tag_Name_webserver`

---

## 7. Using Dynamic Inventory in Real Projects

### ✅ Example Playbook

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

### ✅ Optional: Use Database Inventory (Advanced)

You can write a **custom Python script** to query a database (like PostgreSQL) that holds metadata for hosts. Ansible supports executable inventory scripts.

For now, this is optional and can be added later when your infra grows.

---

## 8. Conclusion / Recommendation

Dynamic Inventory in Ansible helps manage cloud infrastructure in real-time by pulling host information directly from AWS. It replaces static IP-based inventories and improves automation, tagging, and scalability. Use optional database sources only if your setup includes metadata outside AWS.

---

## 9. Contact Information

**Author**: Prince Batra  
**Email**: prince98batra@gmail.com  
**GitHub**: [github.com/prince98batra](https://github.com/prince98batra)

---

## 10. References

| Reference                               | Link                                                                 |
|-----------------------------------------|----------------------------------------------------------------------|
| AWS EC2 Inventory Plugin                | https://docs.ansible.com/ansible/latest/plugins/inventory/aws_ec2.html |
| Ansible Inventory User Guide            | https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html |
| Custom Inventory Script Dev Guide       | https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html |
| AWS IAM Role for EC2 Dynamic Access     | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html |
```

---

Let me know if you'd like it in `.docx`, `.pdf`, or any format for sharing/submitting.
