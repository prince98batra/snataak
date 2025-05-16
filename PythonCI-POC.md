Got it! Here’s your **Bandit Setup and Usage POC** in the same professional, clean format you provided for the React CI Dependency Scanning POC:

---

# **Bandit Security Scan: Python Project POC**

<p align="center">
  <img src="https://bandit.readthedocs.io/en/latest/_images/bandit_logo.png" alt="Bandit Logo" width="250" />
</p>

**Author Information**

| Created    | Last Updated | Version | Author       | Level           | Reviewer        |
| ---------- | ------------ | ------- | ------------ | --------------- | --------------- |
| 16-05-2025 | 16-05-2025   | V1      | Prince Batra | Internal Review | Siddharth Pawar |

---

### **Table of Contents**

* [1. Introduction](#1-introduction)
* [2. Prerequisites](#2-prerequisites)
* [3. Bandit Scan Document](#3-bandit-scan-document)
* [4. Step-by-Step Instructions](#4-step-by-step-instructions)

  * [4.1 Install Bandit](#41-install-bandit)
  * [4.2 Run Bandit with Terminal Output](#42-run-bandit-with-terminal-output)
  * [4.3 Run Bandit and Save HTML Report](#43-run-bandit-and-save-html-report)
  * [4.4 Manage Multiple Reports](#44-manage-multiple-reports)
  * [4.5 Serve Reports via HTTP](#45-serve-reports-via-http)
  * [4.6 Access Reports from Browser](#46-access-reports-from-browser)
* [5. Conclusion](#5-conclusion)
* [6. Contact Information](#6-contact-information)
* [7. Reference Table](#7-reference-table)

---

### **1. Introduction**

This POC demonstrates how to use **Bandit**, a Python security static analyzer, to scan your Python projects for common security issues. Bandit identifies vulnerabilities early, ensuring secure coding practices and compliance with security standards.

---

### **2. Prerequisites**

* Python installed (version 3.x recommended)
* Pip package manager available
* Python project folder with your source code ready

---

### **3. Bandit Scan Document**

For detailed concepts like "What is Bandit," "Why use Bandit," "Workflow," "Advantages vs Disadvantages," and "Best Practices," refer to the official documentation at:
[Bandit Documentation](https://bandit.readthedocs.io/en/latest/)

---

### **4. Step-by-Step Instructions**

#### **4.1 Install Bandit**

Install Bandit using pip:

```bash
pip install bandit
```

Use `pip3` if your system differentiates Python 3 pip.

---

#### **4.2 Run Bandit with Terminal Output**

Scan your entire project recursively and print the report directly in the terminal for quick review:

```bash
bandit -r .
```

Here, `-r .` means scan all files and subdirectories from the current folder.

---

#### **4.3 Run Bandit and Save HTML Report**

Generate a detailed, user-friendly HTML report that you can open in a browser:

```bash
bandit -r . -f html -o bandit_report.html
```

* `-f html`: Output format HTML
* `-o bandit_report.html`: Save report as this file

---

#### **4.4 Manage Multiple Reports**

When scanning multiple projects, save reports with unique names to prevent overwriting:

```bash
cd ~/project1
bandit -r . -f html -o bandit_report_project1.html

cd ~/project2
bandit -r . -f html -o bandit_report_project2.html
```

---

#### **4.5 Serve Reports via HTTP**

To view reports remotely, serve the report files over HTTP using Python’s built-in server on different ports:

```bash
# Serve project1 report on port 8000
cd ~/project1
python3 -m http.server 8000

# Serve project2 report on port 8001
cd ~/project2
python3 -m http.server 8001
```

---

#### **4.6 Access Reports from Browser**

From your local machine, open the following URLs in a web browser by replacing `<EC2-IP-ADDRESS>` with your server IP:

* Project 1 report:
  `http://<EC2-IP-ADDRESS>:8000/bandit_report_project1.html`

* Project 2 report:
  `http://<EC2-IP-ADDRESS>:8001/bandit_report_project2.html`

---

### **5. Conclusion**

This POC shows how Bandit can be integrated into your Python development process to detect security vulnerabilities early. By producing both quick terminal outputs and detailed HTML reports, Bandit fits well into manual reviews and automated CI/CD pipelines, promoting secure Python code.

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

---

If you want me to help format or customize anything else, just let me know!
