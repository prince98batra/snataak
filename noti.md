## **Notification Application Document**

## **Author Information**
| Created     | Last updated | Version | Author         | Level             | Reviewer        |
|-------------|--------------|---------|----------------|-------------------|-----------------|
| 24-04-2025  | 25-04-2025   | V2      | Prince Batra   | Internal Review   | Siddharth Pawar |

---

## **Table of Contents**

1. [Introduction](#introduction)  
2. [Pre-requisites](#pre-requisites)  
3. [System Requirements](#system-requirements)  
4. [Dependencies](#dependencies)  
5. [Architecture](#architecture)  
6. [Workflow Diagram](#workflow-diagram)  
7. [Step-by-step Installation of Notification Application](#step-by-step-installation-of-notification-application)  
8. [Troubleshooting](#troubleshooting)  
9. [FAQs](#faqs)  
10. [Contact Information](#contact-information)  
11. [Reference Table](#reference-table)  

---

## **Introduction**
The Notification Application is designed to send scheduled email notifications to employees whose data is fetched from an employee database. It enables automatic hourly email reminders using a configured SMTP service.

---

## **Pre-requisites**

- A valid SMTP email configuration.
- Elasticsearch installation with an employee database containing employee emails.
- Python 3.8+ for scripting the notification logic.  
- pip 20+ for managing Python dependencies.  
- Operating System: Ubuntu 22.04 for system compatibility.
  
---

## **System Requirements**
| Hardware Specifications | Recommended Minimum |
|-------------------------|---------------------|
| Processor               | 2 vCPU              |
| RAM                     | 4 GB                |
| Disk                    | 8 GB                |
| OS                      | Ubuntu 22.04        |

The system needs enough resources to run Python scripts, Elasticsearch, and handle periodic email sending without timeouts or latency. A minimum 2 vCPU and 4 GB RAM setup ensures smooth functioning even with moderate load.

---

## **Dependencies**

### Run Time Dependencies
| Name           | Version  | Description                            | Why It’s Needed                                           |
|----------------|----------|----------------------------------------|----------------------------------------------------------|
| Python         | 3.10+    | Main programming language              | Executes logic, handles querying and email sending       |
| pip            | latest   | For managing Python packages           | Manages dependencies                                     |
| Elasticsearch  | 7.17.17  | Used for indexing and querying employee data from the employee database    | Fetches and queries employee data to send notifications     |

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

## **Workflow Diagram**

![1](https://github.com/user-attachments/assets/ae5d95a8-3914-40ea-bd3a-3aac571df734)

---

## **Step-by-step Installation of Notification Application**
Refer to this document for installation instructions: [Installation Guide Link Here](#)

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

## **FAQs**

- **Q: Can I use something other than Gmail?**  
  A: Yes. SendGrid or other SMTP providers can be configured.

- **Q: Can the schedule be changed from hourly?**  
  A: Yes, adjust the cron or scheduler logic in your Python script.

- **Q: Do I need Docker?**  
  A: No, the app runs fine without Docker. Docker support is optional.

---

## **Contact Information**
| Name         | Email Address                                |
|--------------|----------------------------------------------|
| Prince Batra | prince.batra.snaatak@mygurukuam.co           |

---

## **Reference Table**
| Title                              | Link                                                                   |
|------------------------------------|------------------------------------------------------------------------|
| Ubuntu Official Docs               | https://help.ubuntu.com                                               |
| Elasticsearch Installation Guide   | https://www.elastic.co/downloads/                                     |
| Gmail App Password Setup           | https://support.google.com/accounts/answer/185833                     |
| SendGrid SMTP Guide                | https://docs.sendgrid.com/for-developers/sending-email/smtp-api/     |

---
