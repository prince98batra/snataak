# **Setup Commit & PR (Pull Request) workflow**

<p align="center">
  <img src="https://cdn.creazilla.com/icons/3214459/git-pull-request-icon-size_512.png" alt="Pull Request Icon" width="200"/>
</p>

## **Author Information**

| Created    | Last Updated | Version | Author       | Level           | Reviewer        |
| ---------- | ------------ | ------- | ------------ | --------------- | --------------- |
| 12-05-2025 | 12-05-2025   | V1      | Prince Batra | Internal Review | Siddharth Pawar |

## **Table of Contents**

* [1. Introduction](#1-introduction)
* [2. Prerequisites](#2-prerequisites)
* [3. Commit & PR Workflow Strategy](#3-commit--pr-workflow-strategy)
* [4. Step-by-Step Instructions](#4-step-by-step-instructions)
  * [4.1 Log in to GitHub](#41-log-in-to-github)
  * [4.2 Create a Repository](#42-create-a-repository)
  * [4.3 Create a Feature Branch](#43-create-a-feature-branch)
  * [4.4 Make a Change in the Feature Branch](#44-make-a-change-in-the-feature-branch)
  * [4.5 Create a Pull Request (PR)](#45-create-a-pull-request-pr)
  * [4.6 Navigate to Branch Rules Configuration](#46-navigate-to-branch-rules-configuration)
  * [4.7 Enforce Reviewer Sign-Off Rules](#47-enforce-reviewer-sign-off-rules)
  * [4.8 Enforce Jenkins System Validation](#48-enforce-jenkins-system-validation)
  * [4.9 Restrict Merge Access to Lead](#49-restrict-merge-access-to-lead)
* [5. Conclusion](#5-conclusion)
* [6. Contact Information](#6-contact-information)
* [7. Reference Table](#7-reference-table)

---

### **1. Introduction**

This POC outlines a secure and controlled **Commit and Pull Request (PR)** workflow to ensure high-quality code contributions. It enforces a structured branching strategy, mandatory multi-level reviews, Jenkins system validation, and limited merge permissions to maintain repository integrity.

---

### **2. Prerequisites**

* A GitHub repository with admin access.
* Jenkins setup and webhook integration.

---

### **3. Commit & PR Workflow Strategy**

| Criteria                      | Description                                                       |
| ----------------------------- | ----------------------------------------------------------------- |
| **Source Branch**             | Must start with `feature-XXX` (e.g., `feature-001`)               |
| **Target Branch**             | Must always be `main`                                             |
| **Reviewer Sign-Offs**        | Minimum **2 reviewer approvals** required                         |
| **System Sign-Off (Jenkins)** | Jenkins must validate the code through CI pipeline                |
| **Merge Access**              | Only **Lead** users are authorized to perform the final merge     |
| **Code Validation**           | Automated build, linting, and test execution via Jenkins pipeline |

---

### **4. Step-by-Step Instructions**

### 4.1. **Log in to GitHub:**
   Visit [https://github.com](https://github.com) and sign in with your GitHub credentials.

![1](https://github.com/user-attachments/assets/0e0e6015-6b1a-4ac1-a5f9-89402751839e)

### 4.2. **Create a Repository:**
   Create a new repository where you'll configure the commit and pull request workflow.

![2](https://github.com/user-attachments/assets/b11ab1ba-2f94-4b0b-9a6e-690d417f29d7)

### 4.3. **Create a Feature Branch:**
   Once the repository is set up, navigate to it and create a new branch named `feature-001`.

![3](https://github.com/user-attachments/assets/bfd033f0-b45e-4afd-8634-a6cc1644a7ff)

### 4.4. **Make a Change in the Feature Branch:**
   Switch to the `feature-001` branch and make a small change—for example, add a new line of code. Commit this change to simulate a code update.

![4](https://github.com/user-attachments/assets/9f0ecca1-7bd7-4fda-860b-f612074a6707)

### 4.5. **Create a Pull Request (PR):**
   After committing the change, open a pull request from `feature-001` to the `main` branch. This PR can currently be merged unless rules are set.

![5](https://github.com/user-attachments/assets/10cab73a-c1f6-4ff4-b233-c2398694b4cf)

### 4.6. **Navigate to Branch Rules Configuration:**
   To enforce proper PR rules, go to your repository → click on **Branches** → locate the `main` branch → click **Add Rule** under **Branch protection rules**.
   
![7](https://github.com/user-attachments/assets/59eeb11d-3a46-4be6-a478-5d465b6f09ef)

### 4.7. **Two reviewers should give sign-off** 
   Enable **“Require a pull request before merging”** and set **“Required approvals” to 2** under branch protection rules.

![image](https://github.com/user-attachments/assets/35b021c4-1b7a-4383-a39b-118e8ea21c4a)
 
### 4.8. **System (Jenkins) should validate the code before merge**
  Enable **“Require status checks to pass before merging”**, which ensures that only pull requests passing Jenkins build/test checks can be merged.

![image](https://github.com/user-attachments/assets/0771221b-12f8-4ece-8759-7ae3a9f5c215)

### 4.9. **Lead should be able to merge** 
  Use “Restrict who can push to matching branches” and add Team Lead to the bypass list so only they can merge PRs to main.

![image](https://github.com/user-attachments/assets/2b6757f2-f354-4206-aaa2-e160cf1d29ca)

---

## **5. Conclusion**

This document defines a structured commit and pull request workflow to enforce code quality and security. By using branch rules, reviewer approvals, and Jenkins validation, only tested code reaches the main branch. It ensures accountability and supports a reliable, collaborative development process.

---

## **6. Contact Information**

| Name         | Email Address                                                                     |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## **7. Reference Table**

| Title                             | Link                                                                                                                               | Purpose                                         |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| Jenkins GitHub Integration Plugin | [Visit](https://plugins.jenkins.io/github/)                                                                                        | Configure GitHub webhook for Jenkins validation |
| GitHub Pull Request Guide         | [Visit](https://docs.github.com/en/pull-requests)                                                                                  | Understand how to create and manage PRs         |
| Jenkins Pipeline Docs             | [Visit](https://www.jenkins.io/doc/book/pipeline/)                                                                                 | Reference for setting up Jenkins CI pipelines   |
