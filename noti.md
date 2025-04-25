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
5. [Component Explanation](#component-explanation)  
6. [Architecture](#architecture)  
7. [Dataflow Diagram](#dataflow-diagram)  
8. [Step-by-step Installation of Notification Application](#step-by-step-installation-of-notification-application)  
9. [Troubleshooting](#troubleshooting)  
10. [FAQs](#faqs)  
11. [Contact Information](#contact-information)  
12. [References](#references)  

---

## **Introduction**
The Notification Application is designed to send scheduled email notifications to employees whose data is stored in an Elasticsearch index. It enables automatic hourly email reminders using a configured SMTP service, typically Gmail or SendGrid.

---

## **Pre-requisites**

- A valid SMTP email configuration (Gmail App Password OR SendGrid SMTP).
- An Elasticsearch instance with an `employee-management` index containing employee emails.

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

### Run Time Dependency
| Name           | Version  | Description                            |
|----------------|----------|----------------------------------------|
| Python         | 3.10+    | Main programming language               |
| pip            | latest   | For managing Python packages            |
| Elasticsearch  | 7.17.17  | Stores and retrieves employee data      |

**Python**  
Python serves as the backbone for scripting the notification logic and querying Elasticsearch.

**Elasticsearch**
It stores employee data, including email addresses. The notification script queries it every hour to check for active employees.

### Other Dependencies
| Name           | Description                                 |
|----------------|---------------------------------------------|
| SMTP Email     | Used for sending scheduled notifications    |

**SMTP Server**  
Used to send scheduled emails. Can be configured using Gmail SMTP (with app password) or services like SendGrid (with API key).

### Important Ports
| Inbound Traffic | Description                  |
|------------------|------------------------------|
| 9200             | Elasticsearch HTTP Interface |

### Others
| Configuration         | Description                           |
|------------------------|---------------------------------------|
| App password / API key | Required for authenticating with SMTP |

---

## **Component needed**



---

### Components Summary Table

| Component       | Why It’s Needed                                           |
|------------------|-----------------------------------------------------------|
| Python           | Executes logic, handles querying and email sending        |
| Elasticsearch    | Stores employee email data queried for notifications      |
| SMTP (Gmail/SG)  | Sends email notifications                                 |

---

## **Workflow Diagram**

![1](https://github.com/user-attachments/assets/ae5d95a8-3914-40ea-bd3a-3aac571df734)
 
---

## **Dataflow Diagram**

1. Employee data is added to Elasticsearch (`employee-management` index).
2. Notification script queries it hourly.
3. Email content is dynamically generated.
4. Email is sent using configured SMTP credentials.


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

## **References**
| Title                              | Link                                                                   |
|------------------------------------|------------------------------------------------------------------------|
| Ubuntu Official Docs               | https://help.ubuntu.com                                               |
| Elasticsearch Installation Guide   | https://www.elastic.co/downloads/                                     |
| Gmail App Password Setup           | https://support.google.com/accounts/answer/185833                     |
| SendGrid SMTP Guide                | https://docs.sendgrid.com/for-developers/sending-email/smtp-api/     |

