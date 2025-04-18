<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/1664px-Ansible_logo.svg.png" alt="Ansible Logo" width="200"/>
</p>

# Ansible Dynamic Inventory

## 👤 **Author Information**
| **Created**       | **Version** | **Last Modified** | **Author**        | **Level**            | **Reviewer**  |
|--------------------|-------------|-------------------|-------------------|------------------------|---------------|
| 18-04-2025         | V1          | 18-04-2025        | Prince Batra    | Internal review        | Siddharth Pawar        |
| 18-04-2025         | V1          | 18-04-2025        | Prince Batra      | L0 Review | Shikha        |

---

## 📘 Table of Contents

1. [Purpose of the Document](#1-purpose-of-the-document)
2. [What is Common Stack, Inventory, and Dynamic Inventory?](#2-what-is-common-stack-inventory-and-dynamic-inventory)
3. [Why Use Dynamic Inventory in Ansible?](#3-why-use-dynamic-inventory-in-ansible)
4. [Advantages](#4-advantages)
5. [Disadvantages](#5-disadvantages)
6. [Best Practices](#6-best-practices)
7. [Flow Diagram](#7-flow-diagram)
8. [Conclusion / Recommendation](#8-conclusion--recommendation)
9. [Contact Information](#9-contact-information)
10. [Reference Table](#10-reference-table)

---

## 1. Purpose of the Document

To provide a clear understanding of how to use Ansible's dynamic inventory system with both cloud sources (like AWS) and other sources (like databases). This includes fetching host details, using plugins, and applying roles to configure infrastructure dynamically.

---

## 3. Why Use Dynamic Inventory in Ansible?

- For environments where infrastructure changes frequently (like cloud).
- Avoids the need for static IPs or manual host listing.
- Supports tagging, filtering, and real-time updates.
- Can integrate multiple sources (e.g., AWS, databases).

---

## 4. Advantages

- Automatically updates host lists.
- Easily scalable with tags or filters.
- Reduces configuration drift.
- Compatible with CMDBs and databases.

---

## 5. Disadvantages

- Requires more setup than static inventory.
- Needs plugin-specific configuration.
- May introduce complexity in debugging.

---

## 6. Best Practices

- Use **host tags** in cloud platforms to filter relevant machines.
- Store plugin configuration in a separate inventory directory.
- Cache inventory results if querying a large number of hosts.
- Separate your **inventory source logic** from playbook logic.
- Combine inventory from multiple sources using `ansible-inventory --merge`.
- Always test your dynamic inventory with `ansible-inventory --list -i inventory_dir/`.

---

## 7. Flow Diagram

```
                        +------------------+
                        |   AWS (EC2)      |
                        |  Tag-based Hosts |
                        +------------------+
                                 |
                                 v
                     +------------------------+
                     | Ansible aws_ec2 Plugin |
                     +------------------------+
                                 |
                                 v
                        +----------------+
                        |                |
                        | Dynamic        |
                        | Inventory File |
                        | (aws_ec2.yml)  |
                        |                |
                        +----------------+
                                 ^
                                 |
                     +------------------------+
                     |    Metadata Database    |
                     | (PostgreSQL / SQLite)   |
                     +------------------------+
                                 |
                                 v
              +--------------------------------------+
              |  Custom Python Script (db_inventory) |
              +--------------------------------------+

                                 |
                                 v
                       +--------------------+
                       |                    |
                       | Final Inventory    |
                       | (Merged, Real-Time)|
                       +--------------------+
                                 |
                                 v
                      +-------------------------+
                      | Ansible Playbook / Role |
                      +-------------------------+
```

---

## 8. Conclusion / Recommendation

Use Ansible's dynamic inventory to manage changing infrastructure automatically. Combine cloud sources like AWS and metadata stored in databases to ensure that your inventories are always accurate and up to date. Make use of existing roles and modularize configurations for better scalability.

---

---

## 10. Reference Table

| Reference | Link/Detail |
|----------|--------------|
| Ansible Dynamic Inventory Plugin Docs | https://docs.ansible.com/ansible/latest/plugins/inventory/aws_ec2.html |
| Ansible Inventory Guide | https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html |
| Sample aws_ec2.yml | https://github.com/ansible-collections/amazon.aws/blob/main/docs/aws_ec2_inventory.rst |
| Custom Inventory Script | https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html |
| EC2 IAM Role Config for Dynamic Inventory | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html |

---

