# GoLang CI: Dependency Scanning POC

<p align="center">
  <img src="https://i0.wp.com/beyondxscratch.com/wp-content/uploads/2018/08/dc.png?resize=351%2C111&ssl=1" alt="Dependency Scanning" width="400" height="130" />
</p>

**Author Information**

| Created    | Last Updated | Version | Author       | Level           | Reviewer        |
| ---------- | ------------ | ------- | ------------ | --------------- | --------------- |
| 18-05-2025 | 18-05-2025   | V1      | Prince Batra | Internal Review | Siddharth Pawar |
| 18-05-2025 | 18-05-2025   | V2      | Prince Batra | L0 Review       | Shikha          |
| 18-05-2025 | 18-05-2025   | V3      | Prince Batra | L1 Review       | Kirti Nehra     |

---

### **Table of Contents**

* [1. Introduction](#1-introduction)
* [2. Prerequisites](#2-prerequisites)
* [Dependency Scanning Document](#3-dependency-scanning-document)
* [4. Step-by-Step Instructions](#4-step-by-step-instructions)

  * [4.1 Install OWASP Dependency-Check](#41-install-owasp-dependency-check)
  * [4.2 Run the Dependency Scan in project folder](#42-run-the-dependency-scan-in-project-folder)
  * [4.3 View the Report](#43-view-the-report)
* [5. Conclusion](#5-conclusion)
* [6. Contact Information](#6-contact-information)
* [7. Reference Table](#7-reference-table)

---

### **1. Introduction**

This POC shows how to integrate OWASP Dependency-Check into a Go project (employee-api) to identify vulnerable third-party packages. The scan uses the go.sum file as a source of dependencies and produces an HTML report. All steps are executed in a CI-friendly way using basic terminal commands.

---

### **2. Prerequisites**

* **OpenJDK 11 Runtime Environment** (required to run the OWASP Dependency-Check tool)
* **Unzip utility** (used to extract the downloaded ZIP file)
* **Python 3** – Required to serve the HTML report locally using a simple HTTP server (optional)

---

### **3. Dependency Scanning Document**

Refer to this link for ["What is Dependency Scanning", "Why Use Dependency Scanning", "Workflow Diagram", "Available Tools", "Tool Comparison", "Advantages vs Disadvantages", and "Best Practices"](https://github.com/snaatak-Downtime-Crew/Documentation/blob/SCRUMS-155-PRINCE/application-ci/checks/react/dependency-scanning/documentation/README.md).

---

### **4. Step-by-Step Instructions**

#### **4.1 Install OWASP Dependency-Check**

```bash
wget https://github.com/jeremylong/DependencyCheck/releases/download/v8.4.0/dependency-check-8.4.0-release.zip
unzip dependency-check-8.4.0-release.zip
chmod +x ~/dependency-check/bin/dependency-check.sh
```
![image](https://github.com/user-attachments/assets/3e321bb4-19cb-44ae-b66b-5e4cb652f9e7)

Confirm installation:

```bash
~/dependency-check/bin/dependency-check.sh --version
```

![image](https://github.com/user-attachments/assets/8d223694-9b9b-471b-b1b9-51c950693f5a)

Expected output: `Dependency-Check Core version 8.4.0`

---

#### **4.2 Run the Dependency Scan in project folder**

```bash
cd ~/employee-api
~/dependency-check/bin/dependency-check.sh \
  --project "employee-api" \
  --scan . \
  --format "HTML" \
  --out ./dependency-check-report
```

This command will:

* Scan your Go project directory
* Generate an HTML report
* Save it in a folder named `dependency-check-report`

![image](https://github.com/user-attachments/assets/6211d4a0-919f-40b2-8f41-47e27b9c3bd1)

---

#### **4.3 View the Report**

After the scan finishes, you’ll find your report at:

```bash
~/employee-api/dependency-check-report/dependency-check-report.html
```

You can either:

* Download the file using SCP
* Or serve it via Python HTTP server:

```bash
cd ~/employee-api/dependency-check-report
python3 -m http.server 8080
```
![image](https://github.com/user-attachments/assets/2bf0d349-d9a2-4d87-87a6-6be561e7f9d5)

Then open in browser:

```
http://<your-ec2-ip>:8080/dependency-check-report.html
```
![image](https://github.com/user-attachments/assets/21bebed5-77a3-4df7-88ac-be1f4af7a5c1)

![image](https://github.com/user-attachments/assets/d9f1134e-8282-4b12-932e-298bffbcab01)

---

### **5. Conclusion**

This POC demonstrates the integration of OWASP Dependency-Check for identifying vulnerabilities in Go modules. The scan produced a structured HTML report highlighting known security issues. This approach helps maintain visibility and control over third-party risks in Go projects.

---

### **6. Contact Information**

| Name         | Email Address                                                                     |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

### **7. Reference Table**

| Links                                                                        | Overview                                   |
| ---------------------------------------------------------------------------- | ------------------------------------------ |
| [OWASP Dependency-Check Docs](https://jeremylong.github.io/DependencyCheck/) | Official documentation                     |
| [GitHub Releases](https://github.com/jeremylong/DependencyCheck/releases)    | Download latest OWASP Dependency-Check     |
| [Go Modules](https://golang.org/ref/mod)                                     | Learn more about `go.mod` and dependencies |
