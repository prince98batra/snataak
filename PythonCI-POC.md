# **Python CI Checks Bugs Analysis Document**

<p align="center">
  <img src="https://cdn3.iconfinder.com/data/icons/colourful-seo/512/06-512.png" alt="Bug Analysis Icon" width="170" />
</p>

**Author Information**

| Created    | Last Updated | Version | Author       | Level           | Reviewer        |
| ---------- | ------------ | ------- | ------------ | --------------- | --------------- |
| 16-05-2025 | 16-05-2025   | V1      | Prince Batra | Internal Review | Siddharth Pawar |
| 16-05-2025 | 16-05-2025   | V2      | Prince Batra | L0 Review       | Shikha          |
| 16-05-2025 | 16-05-2025   | V3      | Prince Batra | L1 Review       | Kirti Nehra     |

---

### **Table of Contents**

* [1. Introduction](#1-introduction)
* [2. Prerequisites](#2-prerequisites)
* [3. Python CI Checks Bugs Analysis Document](#3-python-ci-checks-bugs-analysis-document)
* [4. Step-by-Step Instructions](#4-step-by-step-instructions)

  * [4.1 Install Bandit](#41-install-bandit)
  * [4.2 Run Bandit with Terminal Output](#42-run-bandit-with-terminal-output)
  * [4.3 Manage Reports for Attendance and Notification Projects](#43-manage-reports-for-attendance-and-notification-projects)
  * [4.4 Serve Reports via HTTP](#44-serve-reports-via-http)
  * [4.5 Access Reports from Browser](#45-access-reports-from-browser)
* [5. Conclusion](#5-conclusion)
* [6. Contact Information](#6-contact-information)
* [7. Reference Table](#7-reference-table)

---

### **1. Introduction**

This POC demonstrates how to use **Bandit**, a Python security static analysis tool, to identify vulnerabilities in your code. It helps enforce secure coding practices across your Python services like attendance APIs or background workers.

---

### **2. Prerequisites**

* Python installed (version 3.x recommended)
* Pip package manager available

---

### **3. Python CI Checks Bugs Analysis Document**

Refer to this link for ["What is Python CI Bugs Analysis?", "Why Use Python CI Bugs Analysis?", "Workflow Diagram", "Available Tools", "Tool Comparison", "Advantages vs Disadvantages", and "Best Practices".]()

---

### **4. Step-by-Step Instructions**

#### **4.1 Install Bandit**

```bash
pip install bandit
```

> Use `pip3` if your system uses it for Python 3 (e.g., `pip3 install bandit`)

![bandit 1](https://github.com/user-attachments/assets/0685b9eb-5a5c-44c4-a9db-fd339064a322)

---

#### **4.2 Run Bandit with Terminal Output**

To quickly scan all Python files and print results to terminal:

```bash
bandit -r .
```

* `-r .` = Recursive scan of current directory and subfolders

![bandit 5](https://github.com/user-attachments/assets/2757413d-1db6-45b7-8da2-9fdfc726500c)
![bandit 4](https://github.com/user-attachments/assets/ef18088e-829a-45e3-ab6c-e5c00d4cb05a)
![bandit 6](https://github.com/user-attachments/assets/772c1627-8f54-4de0-840e-0f2c028be8f1)

---

#### **4.3 Manage Reports for Attendance and Notification Projects**

Create detailed HTML reports for each project to avoid overwrites:

```bash
# Attendance API
cd ~/attendance-api
bandit -r . -f html -o bandit_report_attendance.html
```

![bandit 3](https://github.com/user-attachments/assets/fbc225e2-fdf9-43de-ab6d-5dcab522b7ed)

```bash
# Notification Worker
cd ~/notification-worker
bandit -r . -f html -o bandit_report_notification.html
```

![bandit 2](https://github.com/user-attachments/assets/7f18b97f-6a4f-49de-bfb0-a79efd1dd3d7)

* `-f html`: Format is HTML
* `-o bandit_report.html`: Output file name
  
---

#### **4.4 Serve Reports via HTTP**

You can make the reports accessible via a browser using Python's built-in HTTP server:

```bash
# Attendance API on port 8000
cd ~/attendance-api
python3 -m http.server 8000
```
![bandit 8](https://github.com/user-attachments/assets/da7b0587-2018-4f68-b12e-e60c87504ef8)


```bash
# Notification Worker on port 8001
cd ~/notification-worker
python3 -m http.server 8001
```
![bandit 7](https://github.com/user-attachments/assets/71cb0823-f02a-4766-868b-b5c6043851c3)

---

#### **4.5 Access Reports from Browser**

Replace `<EC2-IP-ADDRESS>` with your instance's public IP address.

* **Attendance API Report**
  `http://<EC2-IP-ADDRESS>:8000/bandit_report_attendance.html`

![bandit 9](https://github.com/user-attachments/assets/e1f352ca-709a-4092-b4e1-041d75f0d8a2)

* **Notification Worker Report**
  `http://<EC2-IP-ADDRESS>:8001/bandit_report_notification.html`

![bandit 10](https://github.com/user-attachments/assets/48028fab-e8ed-47b0-b4d0-f6c7983b3a37)

---

### **5. Conclusion**

This POC concludes that Bandit effectively identifies and mitigates security vulnerabilities in Python projects. It supports enforcing secure coding during the CI phase. HTML reports served via HTTP enable easy access, ideal for developer workflows and CI/CD integration.

---

### **6. Contact Information**

| Name         | Email Address                                                                     |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

### **7. Reference Table**

| Links                                                                     | Overview                                 |
| ------------------------------------------------------------------------- | ---------------------------------------- |
| [Bandit Official Documentation](https://bandit.readthedocs.io/en/latest/) | Comprehensive Bandit usage and guides    |
| [Bandit GitHub Repository](https://github.com/PyCQA/bandit)               | Source code and community issues tracker |


