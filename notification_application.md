## **Notification Application Document**

<p align="center">
  <img src="https://thaka.bing.com/th/id/OIP.g9SdunVmLqkrgtyX2RvRHgHaHa?w=173&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7" width="150">
</p>

## **Author Information**
| Created     | Last updated | Version | Author         | Level | Reviewer |
|-------------|--------------|---------|----------------|-------|----------|
| 25-04-2025  | 28-04-2025   | V1.1     | Prince Batra   | Internal Review | Siddharth Pawar |
| 25-04-2025  | 28-04-2025   | V2      | Prince Batra   | L0 Review        | Shikha |
| 25-04-2025  | 28-04-2025 |  V3    | Prince Batra  |     L1 Review    | Kirti Nehra   |

---

## **Table of Contents**

1. [Introduction](#introduction)  
2. [Why Need This Application?](#why-need-this-application)  
3. [What Problems Does It Resolve?](#what-problems-does-it-resolve)  
4. [Pre-requisites](#pre-requisites)  
5. [Dependencies](#dependencies)  
6. [Architecture](#architecture)  
7. [Workflow Diagram](#workflow-diagram)
8. [Step-by-step Setup of Notification API](#step-by-step-setup-of-notification-api)
9. [Troubleshooting](#troubleshooting)  
10. [Contact Information](#contact-information)  
11. [Reference Table](#reference-table)  

---

## **Introduction**
The Notification Application is designed to send scheduled email notifications to employees whose data is fetched from an employee database. It enables automatic hourly email reminders using a configured SMTP service.

---

## Why Need This Application?

- To automate the notification process for informing employees about their salary slip generation.  
- To integrate seamlessly with internal APIs like the Employee API and Salary API.  
- To reduce manual effort required by HR or admin teams in sending repetitive emails.  
- To ensure timely and consistent communication to all employees.  
- To improve efficiency by using a scheduled Python script with SMTP integration.

---

## What Problems Does It Resolve?

- Eliminates the need for manual tracking and emailing about salary slips.  
- Prevents delays or missed notifications to employees.  
- Solves the issue of scalability—one notification service handles all employees automatically.  
- Reduces human error in communicating sensitive financial information.  
- Offers centralized and configurable control over email content and scheduling.

---

## **Pre-requisites**

- A valid SMTP email configuration.
- Elasticsearch installation with an employee database containing employee emails.
- Python 3.8+ for scripting the notification logic.  
- pip 20+ for managing Python dependencies.  
- Operating System: Ubuntu 22.04 for system compatibility.
  
---

## **Dependencies**

### Run Time Dependencies
| Name           | Version  | Description                            | 
|----------------|----------|----------------------------------------|
| Python         | 3.10+    | Main programming language              | 
| pip            | latest   | For managing Python packages           | 
| Elasticsearch  | 7.17.17  | Used for indexing and querying employee data from the employee database    |

### Other Dependencies
| Name           | Description                                 | Why It’s Needed                                         |
|----------------|---------------------------------------------|--------------------------------------------------------|
| SMTP Email     | Used for sending scheduled notifications    | Sends email notifications                               |

**Important Ports**
| Inbound Traffic | Description                      |
|------------------|----------------------------------|
| 9200             | Elasticsearch HTTP Interface     |

**Others**
| Configuration         | Description                           |
|------------------------|---------------------------------------|
| App password / API key | Required for authenticating with SMTP |

---

## **Architecture**

![image](https://github.com/user-attachments/assets/ae8c7bcd-d6fc-43d0-9980-af33e58f32c2)

---

## **Workflow Diagram**

![1](https://github.com/user-attachments/assets/ae5d95a8-3914-40ea-bd3a-3aac571df734)

---

## **Step-by-step Setup of Notification API**

>  **Follow step here**: [Refer this POC](https://github.com/snaatak-Downtime-Crew/Documentation/blob/SCRUMS-74-Prateek/ot-ms-understanding/notification/poc/README.md#step-by-step-installation)

---

## **Troubleshooting**

| Problem                     | Solution                                                                 |
|-----------------------------|--------------------------------------------------------------------------|
| Python not found            | Install Python 3.10 and ensure it’s added to PATH                       |
| Virtual environment errors  | Activate using `source venv/bin/activate` before running any scripts     |
| Elasticsearch won’t start   | Check service logs via `journalctl -u elasticsearch`                     |
| SMTP error (Gmail)          | Use app-password; not your main password                                 |
| Email not delivered         | Check config for correct email, port, and credentials                    |

---

## **Contact Information**
| Name         | Email Address                                |
|--------------|----------------------------------------------|
| Prince Batra | prince.batra.snaatak@mygurukuam.co           |

---

### **Reference Table**

| Title                              | Link                                                                 | Description                                                                 |
|------------------------------------|----------------------------------------------------------------------|-----------------------------------------------------------------------------|
| Elasticsearch Installation Guide   | [elastic.co](https://www.elastic.co/downloads/elasticsearch)         | Installation guide for Elasticsearch, used to store and query employee data. |
| Gmail App Password Setup           | [google.com](https://support.google.com/accounts/answer/185833)      | Instructions to generate app password for Gmail SMTP usage.               |
| pip Documentation                  | [pip.pypa.io](https://pip.pypa.io/en/stable/installation/)           | Guide for installing and using pip, Python's package manager.              |
| Elasticsearch Python Client Docs  | [elastic.co](https://elasticsearch-py.readthedocs.io/en/v7.17.17/)   | Official Python client documentation for interacting with Elasticsearch.  |
| SMTP Overview                      | [wikipedia.org](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) | Background on how SMTP works for sending email.                     |
