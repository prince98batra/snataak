# Ansible Dynamic Inventory

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/1664px-Ansible_logo.svg.png" alt="Ansible Logo" width="130"/>
</p>

## **Author Information**
| Created     | Last updated | Version | Author         | Level | Reviewer |
|-------------|--------------|---------|----------------|-------|----------|
| 18-04-2025  | 18-04-2025   | V1      | Prince Batra   | Internal Review | Siddharth Pawar |
| 18-04-2025  | 20-04-2025   | V2      | Prince Batra   | L0 Review        | Shikha |
| 18-04-2025  | 21-04-2025 |  V3    | Prince Batra  |     L1 Review    | Kirti Nehra   |

---

## Table of Contents

1. [Introduction](#introduction)  
2. [Why Use Dynamic Inventory in Ansible?](#why-use-dynamic-inventory-in-ansible)  
3. [Advantages vs Disadvantages](#advantages-vs-disadvantages)  
4. [Best Practices](#best-practices)  
5. [Ansible Dynamic Inventory for Cloud Providers](#ansible-dynamic-inventory-for-cloud-providers)  
    - [AWS EC2 Dynamic Inventory](#aws-ec2-dynamic-inventory)  
    - [Azure VM Dynamic Inventory](#azure-vm-dynamic-inventory)  
    - [GCP Compute Engine Dynamic Inventory](#gcp-compute-engine-dynamic-inventory)  
6. [Custom Database Inventory ](#custom-database-inventory)  
7. [Conclusion](#conclusion)  
8. [Contact Information](#contact-information)  
9. [Reference Table](#reference-table)

---

## Introduction

This document outlines a step-by-step procedure for setting up Ansible’s dynamic inventory with AWS EC2 instances, fetching real-time host details. It eliminates the need for static inventory files and explores integrating custom databases for enhanced automation. The guide also covers best practices and examples for using dynamic inventory with various cloud platforms.

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

 **TIP** | **Reason** |
|-------------------|---------------------------------------|
| **Tag EC2 instances with `Name` and `Environment`** | Use tags like `Name=web-server` and `Environment=dev` on EC2. This helps group and manage them better in your dynamic inventory. |
| **Keep inventory files in an `inventory/` folder** | Store your inventory configuration (like `aws_ec2.yaml`) inside an `inventory/` folder to keep things tidy and organized. |
| **Use `compose:` to define `ansible_host`** | Use `compose:` in your plugin config to set `ansible_host` as the public or private IP of your EC2 instances. Example: `ansible_host: public_ip_address`. |
| **Run `ansible-inventory --list` to verify** | This command shows all the EC2 instances Ansible can detect. It's useful to check if your dynamic inventory is working correctly. |
| **Use `ansible-inventory --graph` to view groupings** | This shows a tree-like structure of your groups and instances. It helps visualize how hosts are grouped (like by environment or name). |

---

---

## Ansible Dynamic Inventory for Cloud Providers

Ansible supports dynamic inventory across multiple cloud platforms using dedicated inventory plugins. Below is a detailed overview for each supported cloud provider, explaining what information is fetched, how the plugin operates, and how it can be configured.

### AWS EC2 Dynamic Inventory

**How it works:**  
The `aws_ec2` plugin uses AWS API (via `boto3`) to fetch a list of EC2 instances across specified regions. You can filter by instance states (e.g., only `running`) and group hosts by tags like `Name` or `Environment`.

**What it fetches:**
- Public and private IP addresses  
- Instance ID, type, state  
- Tags (e.g., Name, Environment)  
- Region, availability zone  
- AMI ID  

**Use case:**  
Fetch all running EC2 instances with a specific tag and use their public IPs in Ansible playbooks.

**Example (`aws_ec2.yml`):**
```yaml
plugin: aws_ec2
regions:
  - us-east-1
filters:
  instance-state-name: running
hostnames:
  - public-ip-address
keyed_groups:
  - key: tags.Environment
```

---

### Azure VM Dynamic Inventory

**How it works:**  
The `azure_rm` plugin connects to Azure Resource Manager and collects VM details from selected resource groups or subscriptions. You can group by tags, OS types, or locations.

**What it fetches:**
- VM name, size, power state  
- Public/private IPs  
- Tags (e.g., app = web)  
- Resource group, region  
- OS details  

**Use case:**  
Manage only Linux VMs in a specific Azure Resource Group, grouped by environment tag.

**Example (`azure_rm.yml`):**
```yaml
plugin: azure_rm
include_vm_resource_groups:
  - MyResourceGroup
auth_source: auto
keyed_groups:
  - key: tags.Environment
```

---

### GCP Compute Engine Dynamic Inventory

**How it works:**  
The `gcp_compute` plugin connects using a service account and fetches VM instances in a given project and zone. Grouping is supported by labels or zones.

**What it fetches:**
- Internal and external IPs  
- VM name, zone  
- Labels, metadata  
- Machine type  
- Network interfaces  

**Use case:**  
Run patch management on all GCP VMs in `us-central1-a` zone.

**Example (`gcp_compute.yml`):**
```yaml
plugin: gcp_compute
projects:
  - my-gcp-project
zones:
  - us-central1-a
auth_kind: serviceaccount
service_account_file: /path/to/credentials.json
hostnames:
  - networkInterfaces[0].accessConfigs[0].natIP
```

---

### Custom Database Inventory 

#### What is it?
With Custom Database Inventory, you can use your own database (such as MySQL, PostgreSQL, etc.) to dynamically manage the servers Ansible should automate. This removes the need to manually maintain static inventory files.

#### What It Fetches from the Database
The database can provide various server-related information, including:  
- **Server IP addresses** or **hostnames**  
- **Group information** (e.g., `app`, `db`, `web`)  
- **Tags or roles** (e.g., `prod`, `dev`)  
- **Any other custom data** you store in your database, such as location or server type  

#### How It Works – Step-by-Step

1. **Store Server Info in Your Database**  
   Create a table in your database with necessary columns. For example:
   - **hostname**  
   - **IP address**  
   - **group_name** (e.g., `app`, `db`)  
   - **tags** (optional, e.g., `prod`, `dev`)  

2. **Write a Script (Usually Python)**  
   Create a Python script that:  
   - Connects to your database  
   - Fetches the required server details  
   - Outputs the data in **JSON format** (which Ansible can understand)

3. **Make Your Script Executable**  
   Use the following command to mark the script as executable:  
   ```bash
   chmod +x db_inventory.py
   ```

4. **Run the Script with Ansible**  
   Execute the script with Ansible to fetch the dynamic inventory:
   ```bash
   ansible-inventory -i db_inventory.py --list
   ```

---

## Conclusion

Dynamic Inventory in Ansible automates infrastructure management by fetching real-time host information from cloud platforms or custom databases, ensuring up-to-date data without manual updates. It simplifies managing dynamic and auto-scaling environments, improves automation, and supports grouping by tags or custom metadata. By adopting best practices, you can streamline automation and enhance scalability across multiple cloud providers.

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
