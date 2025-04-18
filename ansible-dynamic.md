<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Ansible_logo.svg/1664px-Ansible_logo.svg.png" alt="Ansible Logo" width="200"/>
</p>

# Ansible Dynamic Inventory

## 👤 **Author Information**
| **Created**       | **Version** | **Last Modified** | **Author**        | **Level**            | **Reviewer**  |
|------------------|-------------|-------------------|-------------------|----------------------|---------------|
| 18-04-2025       | V1          | 18-04-2025        | Prince Batra      | Internal review      | Siddharth Pawar |
| 18-04-2025       | V1          | 18-04-2025        | Prince Batra      | L0 Review            | Shikha          |

---

## 📘 Table of Contents

1. [Purpose of the Document](#1-purpose-of-the-document)  
2. [Why Use Dynamic Inventory in Ansible?](#2-why-use-dynamic-inventory-in-ansible)  
3. [Advantages vs Disadvantages](#3-advantages-vs-disadvantages)  
4. [Best Practices](#4-best-practices)  
5. [Simple Flow Diagram](#5-simple-flow-diagram)  
6. [Conclusion / Recommendation](#6-conclusion--recommendation)  
7. [Contact Information](#7-contact-information)  
8. [Reference Table](#8-reference-table)  

---

## 1. Purpose of the Document

To provide a clear understanding of how to use Ansible's dynamic inventory system with both cloud sources (like AWS) and other sources (like databases). This includes fetching host details, using plugins, and applying roles to configure infrastructure dynamically.

---

## 2. Why Use Dynamic Inventory in Ansible?

- Ideal for dynamic environments (like AWS EC2).
- Automatically fetches live hosts without manual updates.
- Supports filtering based on tags or instance states.
- Can combine multiple inventory sources (e.g., AWS + database).

---

## 3. Advantages vs Disadvantages

| **Advantages**                                      | **Disadvantages**                                 |
|-----------------------------------------------------|---------------------------------------------------|
| Automatically updates host list                     | Requires more setup than static inventory         |
| Scales easily with cloud tags and filters           | Plugin-specific configuration needed              |
| Reduces risk of configuration drift                 | Can be harder to debug due to dynamic nature      |
| Supports multiple inventory sources (AWS, DB, etc.) | Slightly complex for beginners                    |

---

## 4. Best Practices

- Tag instances properly for easier grouping and filtering.
- Store dynamic inventory files (like `aws_ec2.yml`) in a dedicated inventory directory.
- Use caching for large infrastructures to improve performance.
- Keep inventory logic separate from playbook logic.
- Merge multiple inventories using `ansible-inventory --merge`.
- Always test your inventory using:
  ```bash
  ansible-inventory --list -i inventory_dir/
  ```

---

## 5. Simple Flow Diagram

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

## 6. Conclusion / Recommendation

Use dynamic inventory to keep your host lists always up-to-date, especially when working in cloud environments. Combine cloud-native inventory (like AWS EC2) with additional sources like databases if needed. Stick to best practices like tagging, separating logic, and caching to get the most reliable and scalable setup.

---

## 7. Contact Information

**Author**: Prince Batra  
**Email**: prince98batra@gmail.com  
**GitHub**: [github.com/prince98batra](https://github.com/prince98batra)

---

## 8. Reference Table

| Reference | Link/Detail |
|----------|--------------|
| Ansible Dynamic Inventory Plugin Docs | https://docs.ansible.com/ansible/latest/plugins/inventory/aws_ec2.html |
| Ansible Inventory Guide | https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html |
| Sample aws_ec2.yml | https://github.com/ansible-collections/amazon.aws/blob/main/docs/aws_ec2_inventory.rst |
| Custom Inventory Script | https://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html |
| EC2 IAM Role Config for Dynamic Inventory | https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html |

---

