# Ansible Role Directory Structure

## 👤 Author Information

| **Author**      | **Created on** | **Version**  | **Comment**         | **Reviewer**       |
|------------------|----------------|--------------|----------------------|---------------------|
| **Prince Batra** | 17-04-2025     | Version 1    | Internal review      | Siddharth Pawar     |
| **Prince Batra** | 17-04-2025     | Version 1    | L0 review            | Shikha              |

## 📑 Table of Contents

1. [Introduction](#1-introduction)  
2. [Purpose](#2-purpose)  
3. [How to Create an Ansible Role](#3-how-to-create-an-ansible-role)  
4. [Directory Breakdown (with Purpose, Use Case, and Example)](#4-directory-breakdown-with-purpose-use-case-and-example)  
   - [defaults/](#defaults)  
   - [files/](#files)  
   - [handlers/](#handlers)  
   - [meta/](#meta)  
   - [tasks/](#tasks)  
   - [templates/](#templates)  
   - [vars/](#vars)  
   - [tests/](#tests)  
   - [README.md](#readmemd)  
5. [Best Practices](#5-best-practices)  
6. [Contact Information](#contact-information)  
7. [References](#-references)

---

## 1. Introduction

This document describes the standard directory structure used in an Ansible Role. It is intended to guide both beginners and experienced engineers in organizing automation code for clarity, reusability, and scalability.

---

## 2. Purpose

The purpose of this guide is to:

- Help teams follow a consistent Ansible role structure  
- Explain the purpose of each folder and file in a role  
- Show how each part contributes to the role's functionality  

---

## 3. How to Create an Ansible Role

To create a new role with the standard directory structure, use the following general command:

```bash
ansible-galaxy init <role_name>
```

**Example:** To create a role named `nginx`, run:

```bash
ansible-galaxy init nginx
```

This will generate the following directory layout:

```
nginx/
├── defaults/      # Default variables (overridable)
├── files/         # Static files to copy
├── handlers/      # Tasks triggered by 'notify'
├── meta/          # Role metadata and dependencies
├── tasks/         # Main list of tasks
├── templates/     # Jinja2 templates
├── tests/         # Role testing playbook
├── vars/          # Internal, fixed variables
└── README.md      # Role documentation
```

---

## 4. Directory Breakdown (with Purpose, Use Case, and Example)

<a id="defaults"></a>
### defaults/


**Purpose:**  
Contains default variables that users can override.

**Use Case:**  
Set the default port or path for the config file.

**Example:** `defaults/main.yml`
```yaml
nginx_port: 80
nginx_conf_path: /etc/nginx/nginx.conf
```

---

<a id="defaults"></a>
### files/

**Purpose:**  
Holds static files to be copied to target hosts.

**Use Case:**  
Deploy a static `index.html` to a web server.

**Example task using file:**
```yaml
- name: Copy index.html
  copy:
    src: index.html
    dest: /var/www/html/index.html
```

---

<a id="defaults"></a>
### handlers/

**Purpose:**  
Contains tasks that run only when notified, e.g., restarting services.

**Use Case:**  
Restart Nginx if the config changes.

**Example:** `handlers/main.yml`
```yaml
- name: restart nginx
  service:
    name: nginx
    state: restarted
```

---

<a id="defaults"></a>
### meta/

**Purpose:**  
Defines metadata like author, license, and dependencies.

**Use Case:**  
Specify role details or dependent roles.

**Example:** `meta/main.yml`
```yaml
galaxy_info:
  author: prince
  description: Install and configure nginx
```

---

<a id="defaults"></a>
### tasks/

**Purpose:**  
The main logic of the role — the actual automation steps.

**Use Case:**  
Install and configure the nginx service.

**Example:** `tasks/main.yml`
```yaml
- name: Install Nginx
  apt:
    name: nginx
    state: present
    update_cache: yes

- name: Copy config template
  template:
    src: nginx.conf.j2
    dest: "{{ nginx_conf_path }}"
  notify: restart nginx
```

---

<a id="defaults"></a>
### templates/

**Purpose:**  
Contains Jinja2 templates rendered with variables.

**Use Case:**  
Create dynamic configuration files.

**Example:** `templates/nginx.conf.j2`
```nginx
server {
  listen {{ nginx_port }};
  location / {
    root /var/www/html;
    index index.html;
  }
}
```

---

<a id="defaults"></a>
### vars/

**Purpose:**  
Holds internal role-specific variables that should not be overridden.

**Use Case:**  
Set internal constants like system users.

**Example:** `vars/main.yml`
```yaml
nginx_user: www-data
```

---

<a id="defaults"></a>
### tests/

**Purpose:**  
Used to validate that the role works correctly in isolation.

**Use Case:**  
Run a test playbook before production usage.

**Example:** `tests/test.yml`
```yaml
- name: Test Nginx Role
  hosts: localhost
  become: yes
  roles:
    - nginx
```

---

<a id="defaults"></a>
### README.md

**Purpose:**  
Provides documentation for how to use the role.

**Use Case:**  
Explain required variables, usage examples, and dependencies.

**Note:**  
This is auto-generated by `ansible-galaxy init`, and should be updated with:
- Role purpose
- Variable documentation
- Example playbooks

---

## 5. Best Practices

- Keep roles focused: one role = one job (e.g., installing nginx)  
- Use `defaults/` for user-overridable variables  
- Use `vars/` only for fixed values not meant to be changed  
- Document every variable and role behavior in `README.md`  
- Separate logic (`tasks/`), configuration (`templates/`), and assets (`files/`)  
- Always test your roles using `tests/` before using in production  

---

## **Contact Information**
| **Name** | **Email Address**        |
|----------|--------------------------|
| **Prince Batra**  | **prince.batra.snaatak@mygurukulam.co**   |

---

## 🔗 References

- [Ansible Role Basics - Official Docs](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
- [Ansible Galaxy Roles Guide](https://galaxy.ansible.com/docs/contributing/creating_role.html)

---
