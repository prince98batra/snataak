[# GitLab Flow  Branching Strategy Documentation

<p align="center">
  <img src="https://about.gitlab.com/images/press/logo/png/gitlab-logo-500.png" width="150" alt="GitLab Logo"/>
</p>

---

## **Author Information**
| Created     | Last updated | Version | Author         | Level | Reviewer |
|-------------|--------------|---------|----------------|-------|----------|
| 28-04-2025  | 28-04-2025   | V1     | Prince Batra   | Internal Review | Siddharth Pawar |
| 28-04-2025  | 28-04-2025   | V2      | Prince Batra   | L0 Review        | Shikha |
| 28-04-2025  | 28-04-2025 |  V3    | Prince Batra  |     L1 Review    | Kirti Nehra   |

---

## Table of Contents
- [Introduction](#introduction)
- [What is GitLab Flow?](#what-is-gitlab-flow)
- [Why GitLab Flow?](#why-gitlab-flow)
- [Workflow Diagram](#workflow-diagram)
- [GitLab Flow Branching Strategy](#gitlab-flow-branching-strategy)
- [Advantages vs Disadvantages](#advantages-vs-disadvantages)
- [Best Practices](#best-practices)
- [Conclusion](#conclusion)
- [Contact Information](#contact-information)
- [References](#references)

---

## Introduction

GitLab Flow is a Git strategy designed to handle real-world software delivery. It combines issue tracking, code review, and CI/CD pipelines, making the development and deployment process smooth and organized.

---

## What is GitLab Flow?

- GitLab Flow is a simple and practical way to manage code using Git.
- It connects code changes with issue tracking and automated deployments (CI/CD).
- It matches real-world environments like development, staging, and production.
- It supports faster, safer releases by keeping the process clean and organized.
- Compared to older models like GitFlow, it is easier and better suited for modern teams.

---

## Why GitLab Flow?

- **Real-world alignment**: GitLab Flow is tailored for real-world development processes, accommodating various environments like development, staging, and production.
- **Issue integration**: It seamlessly integrates with issue tracking, allowing developers to link code changes directly to issues for better traceability.
- **CI/CD support**: Built with continuous integration and deployment in mind, it facilitates automated testing and deployment pipelines.
- **Simplified branching**: The workflow promotes a simplified branching model, reducing complexity and making it easier to manage code changes.
- **Hotfix management**: GitLab Flow allows for quick creation and deployment of hotfixes, ensuring critical issues can be addressed promptly without disrupting the main development flow.

---

## Workflow Diagram

![image](https://github.com/user-attachments/assets/d9869352-905e-40e5-964a-1f50fc6092c6)

---

## GitLab Flow Branching Strategy 

- **Master**:  
  - Base branch for development.
  - Features are branched from and merged back into Master.

- **Feature Branch**:  
  - Created from Master for new features.
  - Merged back to Master when complete.

- **Staging**:  
  - Receives code from Master for pre-production testing.
  - Bugfix branches are created from Staging.

- **Bugfix Branch**:  
  - Created from Staging to fix issues found during testing.
  - Merged back into Staging.

- **Production**:  
  - Final live environment.
  - Updated from Staging after successful tests.
  - Hotfixes are created directly from Production if urgent issues happen.

- **Hotfix Branch**:  
  - Created from Production to fix critical live issues.
  - Merged back into Production, Master, and Staging.

**Flow Summary:**
- Master → Staging → Production
- Features from Master.
- Bugfixes from Staging.
- Hotfixes from Production.

---

## Advantages vs Disadvantages

| **Advantages**                                                           | **Disadvantages**                                                          |
|--------------------------------------------------------------------------|----------------------------------------------------------------------------|
| Connects code with issues and deployments                              | May be overwhelming for teams new to GitLab                             |
| Streamlined CI/CD integration                                          | Can be overkill for very small or solo projects                         |
| Clear structure for features, staging, and hotfixes                    | Requires team discipline for naming and branching                       |
| Supports fast hotfixes and organized deployments                       | Needs setup for protected branches and permissions                      |

---

## Best Practices

| **Practice**                        | **Description**                                                                  |
|------------------------------------|----------------------------------------------------------------------------------|
| Use clear branch names              | Example: `feature/payment`, `hotfix/email-error`                                |
| Always use Merge Requests           | Ensures peer reviews and safe merges                                            |
| Protect key branches                | Prevent direct push to `main`, `staging`, `production`                          |
| Link issues to branches             | Helps track work and provides visibility                                        |
| Set up CI/CD pipelines              | Automate testing and deployment workflows                                       |
| Keep branches short-lived           | Merge frequently to avoid large conflicts                                       |
| Review code before merging          | Add required approvers in GitLab settings                                       |

---

## Conclusion

GitLab Flow provides a smart and effective way to manage development and delivery. It fits naturally into modern teams that use staging and production environments. With the power of GitLab tools like Merge Requests, CI/CD, and protected branches, teams can deliver stable, high-quality code faster.

---

## **Contact Information**

| **Name**        | **Email Address**                          |
|-----------------|--------------------------------------------|
| Prince Batra    | prince.batra.snaatak@mygurukulam.co        |

---

## References

| **Title**                        | **Link**                                                                                           | **Overview**                                                                 |
|----------------------------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| GitLab Flow                      | [Visit](https://docs.gitlab.com/ee/topics/gitlab_flow.html)                                        | Official explanation of GitLab Flow and its models                           |
| GitLab CI/CD                     | [Visit](https://docs.gitlab.com/ee/ci/)                                                             | Learn how to automate testing and deployments using GitLab                   |
| GitLab Branching Models          | [Visit](https://docs.gitlab.com/ee/topics/gitlab_flow.html#branching-models)                       | Different ways to manage branches in GitLab Flow                             |
| GitLab Issues                    | [Visit](https://docs.gitlab.com/ee/user/project/issues/)                                           | Use issues to manage and track tasks                                         |
| GitLab Merge Requests            | [Visit](https://docs.gitlab.com/ee/user/project/merge_requests/)                                   | Learn to submit code for review and merging through MRs                      |

---
](https://github.com/snaatak-Downtime-Crew/Documentation/blob/SCRUMS-102-PRINCE/vcs_design%20+%20poc/branching%20strategy/gitlab%20flow/README.md#advantages-vs-disadvantages)
