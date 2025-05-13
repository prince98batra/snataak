# **License Scanning POC**

<p align="center">
  <img src="https://as1.ftcdn.net/jpg/01/03/58/34/1000_F_103583422_LlVd7SOAdF6HQwj6YwxRfe5hKV9OCpQN.jpg" width="300" alt="License Scanning Logo">
</p>

**Author Information**

| Created    | Version | Last Modified | Author       | Level           | Reviewer        |
| ---------- | ------- | ------------- | ------------ | --------------- | --------------- |
| 13-04-2025 | V1      | 13-04-2025    | Prince Batra | Internal review | Siddharth Pawar |
| 13-04-2025 | V2      | 13-04-2025    | Prince Batra | L0 Review       | Shikha          |

---

### **Table of Contents**

* [Introduction](#1-introduction)
* [Prerequisites](#2-prerequisites)
* [License Scanning Document](#3-license-scanning-document)
* [Step-by-Step Instructions](#4-step-by-step-instructions)

  * [4.1 Set Up FOSSA](#41-step-1-set-up-fossa)
  * [4.2 Configure FOSSA Integration](#42-step-2-configure-fossa-integration)
  * [4.3 Run License Scanning](#43-step-3-run-license-scanning)
  * [4.4 Analyze and Resolve Issues](#44-step-4-analyze-and-resolve-issues)
* [Conclusion](#5-conclusion)
* [Contact Information](#6-contact-information)
* [Reference Table](#7-reference-table)

---

### **1. Introduction**

This Proof of Concept (POC) demonstrates how FOSSA can be integrated into your project to automate license scanning and compliance management. FOSSA helps identify and resolve licensing issues related to third-party dependencies, ensuring your project stays compliant with open-source licenses. The following steps will guide you through setting up FOSSA, scanning your codebase, and handling any detected issues.

---

### **2. Prerequisites**

* Access to a FOSSA account.
* Basic knowledge of license management and compliance.

---

### **3. License Scanning Document**

Refer to this link for "What is License Scanning", "Why Use License Scanning", "Workflow Diagram", "Available Tools", "Tool Comparison", "Advantages vs Disadvantages", "Best Practices", and "Recommendation" of the License Scanning Document.

---

### **4. Step-by-Step Instructions**

#### **4.1: Set Up FOSSA**

1. Sign up for a FOSSA account at [FOSSA Signup](https://fossa.com/signup).
2. After signing up, log in to your FOSSA account.

![image](https://github.com/user-attachments/assets/653dca10-78c7-4e23-bac2-6e3ae4340960)

---

#### **4.2: Configure FOSSA Integration**

**Install FOSSA CLI**

* Run the following script to install the latest version of FOSSA CLI:

  ```bash
  curl https://raw.githubusercontent.com/fossas/fossa-cli/master/install.sh | bash
  fossa --version
  ```

![image](https://github.com/user-attachments/assets/5263335a-72c0-4ff4-b0e4-d39b1f6c70d9)

**Authenticate FOSSA CLI**

* Log in to the FOSSA CLI using your API key generated from FOSSA account:

  ```bash
  export FOSSA_API_KEY=<your_api_key>
  ```

![image](https://github.com/user-attachments/assets/799040c4-f818-41d5-9a58-d414ca466d8c)

**Link your repository**

* Link the repository to FOSSA and verify `.fossa.yml`:

  ```bash
  fossa init
  ```

![image](https://github.com/user-attachments/assets/0745eae4-0a5e-4e28-900f-e93d63a8ef9a)

---

#### **4.3: Run License Scanning**

* Trigger a manual license scan by running:

  ```bash
  fossa analyze
  ```

![image](https://github.com/user-attachments/assets/00f28535-d800-4ac6-a96a-aaf89fc3b591)

---

#### **4.4: Analyze and Resolve Issues**

1. **Review Scan Results on the FOSSA Dashboard**
   Once the scan is complete, view the results on the FOSSA dashboard.

   * If any issues are found (e.g., conflicting or missing licenses), FOSSA will highlight them.
   * Review the detailed report and resolve any flagged issues.
   * FOSSA often suggests appropriate actions such as changing license types or adding proper attributions.

   ![image](https://github.com/user-attachments/assets/7d0fc243-17ff-4d98-aea6-fb71acd2c87f)

2. **Verify Compliance Using `fossa test`**
   After resolving all issues, run the following command to verify that your project is compliant:

   ```bash
   fossa test
   ```

   * If the test passes, the output will indicate `0 issues found`.

   ![image](https://github.com/user-attachments/assets/a2796b37-fa30-478c-99f9-a1df97e0a616)

### **5. Conclusion**

The integration of FOSSA ensures your project maintains proper license compliance by automatically scanning dependencies for potential issues. By following this POC, you've set up a process to detect and resolve license conflicts efficiently, ensuring legal compliance with minimal effort. FOSSA provides a reliable solution for managing open-source dependencies and their associated licenses.

---

### **6. Contact Information**

| Name         | Email Address                                                                     |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

### **7. Reference Table**

| Links                                                             | Overview                                                            |
| ----------------------------------------------------------------- | ------------------------------------------------------------------- |
| [FOSSA Docs](https://fossa.com/docs/)                             | Guides on using FOSSA for license compliance and security scanning. |
| [FOSSA GitHub](https://github.com/fossas/fossa-cli)               | FOSSA's source code and repository for contributors.                |
| [Open Source License Compliance](https://opensource.org/licenses) | General guidelines on open-source license compliance.               |

