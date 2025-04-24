## **Notification Application Document**

---

##  **Author Information**
| Created     | Version | Author        | Last Updated       | Comment          | Reviewer         |
|-------------|---------|---------------|--------------------|------------------|------------------|
| 24-04-2025  | V1      | Prince Batra  |                    | Internal Reviewer| Siddharth Pawar  |

---

##  Table of Contents

1. [Introduction](#introduction)  
2. [Pre-requisites](#pre-requisites)  
3. [System Requirements](#system-requirements)  
4. [Dependencies](#dependencies)  
    - [Build Time Dependency](#build-time-dependency)  
    - [Run Time Dependency](#run-time-dependency)  
    - [Other Dependency](#other-dependency)  
    - [Important Ports](#important-ports)  
    - [Others](#others)  
5. [Architecture](#architecture)  
6. [Dataflow Diagram](#dataflow-diagram)  
7. [Step-by-step Installation of Notification Application](#step-by-step-installation-of-notification-application)  
8. [Troubleshooting](#troubleshooting)  
9. [FAQs](#faqs)  
10. [Contact Information](#contact-information)  
11. [References](#references)  

---

## Introduction
This Notification Application sends scheduled email notifications to employees listed in an Elasticsearch index. The main objective is to enable automatic hourly email reminders using configured SMTP settings. This eliminates the need for manual email operations and integrates seamlessly with a broader employee management system.

## Pre-requisites
Before proceeding with deployment, ensure the following conditions are met:

- You have access to a working internet connection.
- You have a valid SMTP email account (Gmail recommended with app-password enabled).
- You are familiar with basic Linux commands.

## System Requirements
| Hardware Specifications | Minimum Recommendation |
|-------------------------|------------------------|
| Processor               | 2 vCPU (AWS t3.medium) |
| RAM                     | 4 GB                   |
| Disk                    | 8 GB                   |
| OS                      | Ubuntu 22.04           |

**Reason**: A `t3.medium` instance offers 2 vCPUs and 4GB RAM which is sufficient to run Python applications along with Elasticsearch in development or lightweight production environments.

## Dependencies

### Build Time Dependency
| Name         | Version | Description              |
|--------------|---------|--------------------------|
| Git          | latest  | Used to clone repository |

### Run Time Dependency
| Name           | Version | Description                              |
|----------------|---------|------------------------------------------|
| Python         | 3.10+   | Required to run the application          |
| pip            | latest  | Python package installer                  |
| Elasticsearch  | 7.17.17 | Stores employee records with email IDs   |

### Other Dependency
| Name       | Version | Description                        |
|------------|---------|------------------------------------|
| SMTP Email | N/A     | For sending email notifications    |

### Important Ports
| Inbound Traffic | Description                 |
|------------------|-----------------------------|
| 9200             | Used by Elasticsearch HTTP |

| Outbound Traffic | Description            |
|------------------|------------------------|
| 587              | SMTP for Gmail service |

### Others
| Others                  | Description                        |
|-------------------------|------------------------------------|
| App password (Gmail)    | Required for SMTP authentication   |

## Architecture

Below is the architecture for the Notification Application:

### Text Version:
- **User** adds employee data to **Elasticsearch**
- **Notification Service** queries Elasticsearch every hour
- On finding emails, it sends mail using configured **SMTP server**

Components:
- User
- Elasticsearch (employee-management index)
- Notification Application (Python)
- SMTP Server (Gmail)

### Image Version:
> *[Image will be displayed here once generated]*

## Dataflow Diagram

1. Employee data with email is inserted into Elasticsearch index (`employee-management`).
2. Notification script queries this index hourly.
3. Emails are composed using data fetched.
4. Emails are sent via SMTP (e.g., Gmail).

## Step-by-step Installation of Notification Application
Refer to the [Installation Commands and Steps](#) document for detailed commands and configurations.

## Troubleshooting
Common setup issues and solutions:

- **Python not found**: Ensure Python is installed and added to PATH.
- **Virtual environment issues**: Always activate the virtual environment using `source venv/bin/activate`.
- **Elasticsearch not starting**: Check logs via `sudo journalctl -u elasticsearch`.
- **SMTP email errors**: Ensure app password is used instead of regular Gmail password.
- **Email not sending**: Double-check `config.yaml` SMTP credentials and port.

## FAQs
- **Q: Can I use a different email provider other than Gmail?**  
  A: Yes, but make sure you update the SMTP server, port, and credentials in the config file.

- **Q: What if I don’t want to run the app every hour?**  
  A: You can change the schedule logic in `notification_api.py`.

- **Q: Can this work with a Docker setup?**  
  A: Yes, but this guide focuses on running it directly without Docker.

## Contact Information
| Name         | Email Address                                |
|--------------|----------------------------------------------|
| Prince Batra | prince.batra.snaatak@mygurukuam.co           |

## References
| **Title**                  | **Link**                                |
|----------------------------|------------------------------------------|
| Ubuntu Official Docs       | https://help.ubuntu.com                 |
| Elasticsearch Installation | https://www.elastic.co/downloads/      |
| Gmail App Password Guide   | https://support.google.com/accounts/answer/185833 |

