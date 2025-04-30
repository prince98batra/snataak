# VCS Notification Concept Document

<p align="center">
  <img src="https://thaka.bing.com/th/id/OIP.g9SdunVmLqkrgtyX2RvRHgHaHa?w=173&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7" width="150">
</p>

---

## **Author Information**
| Created     | Last updated | Version | Author         | Level | Reviewer |
|-------------|--------------|---------|----------------|-------|----------|
| 29-04-2025  | 29-04-2025   | V1.1    | Prince Batra   | Internal Review | Siddharth Pawar |
| 29-04-2025  | 29-04-2025   | V2      | Prince Batra   | L0 Review        | Shikha |
| 29-04-2025  | 29-04-2025 |  V3    | Prince Batra  |     L1 Review    | Kirti Nehra   |

---

## Table of Contents
- [Introduction](#introduction)
- [Why Notifications in VCS?](#why-notifications-in-vcs)
- [Types of Notifications](#types-of-notifications)
- [Stakeholders](#stakeholders)
- [Events Triggering Notifications](#events-triggering-notifications)
- [Notification Delivery Channels](#notification-delivery-channels)
- [Conclusion](#conclusion)
- [Contact Information](#contact-information)
- [References](#references)

---

## Introduction

This document outlines the Notification Strategy in Version Control Systems (VCS) like GitLab and GitHub. It explains what VCS notifications are, why they are needed, what events trigger them, who they matter to, and how they are delivered. The goal is to provide a clear and practical understanding of how notifications enhance collaboration, transparency, and development workflow.

---

## Why Notifications in VCS?

| **Reason**                | **Explanation**                                                       |
|----------------------------|------------------------------------------------------------------------|
| Faster Collaboration       | Team members can quickly react to updates or issues.                  |
| Better Visibility          | Everyone stays aware of project progress and critical changes.        |
| Error Prevention           | Early alerts help avoid mistakes or missed tasks.                     |
| Audit and Compliance       | Activities are logged for future reference or audits.                 |
| Productivity Improvement   | Saves manual effort checking for updates manually.                    |

---

## Types of Notifications

| **Type**                  | **Description**                                                                 |
|----------------------------|---------------------------------------------------------------------------------|
| Push Notification          | Triggered when someone pushes code to the repository.                           |
| Merge Request Notification | Sent when a merge request is opened, approved, merged, or closed.               |
| Pipeline Notification      | Triggered when a build/test pipeline succeeds, fails, or gets canceled.         |
| Issue Notification         | Triggered when issues are created, updated, or commented on.                    |
| Access Change Notification | Sent when a user's permissions are modified.                                    |
| Tag/Release Notification   | Sent when a new version (tag) or release is published.                          |
| Security Alerts            | Sent when vulnerabilities or security issues are detected.                     |

---

## Stakeholders

| **Stakeholder**         | **Role**                     | **Interest in Notifications**                                             |
|--------------------------|-------------------------------|---------------------------------------------------------------------------|
| Developer                | Code Contributor              | Wants updates about code reviews, build status, and deployments.         |
| QA Engineer              | Quality Assurance             | Needs alerts about test case failures, builds, and release readiness.    |
| Project Manager          | Project Oversight             | Tracks project progress, issues, releases, and team activities.          |
| Security Team            | Security Monitoring           | Monitors access changes, vulnerabilities, and security-related events.   |
| DevOps Engineer          | Infrastructure & Automation   | Watches build pipelines, deployment statuses, and system operations.     |

---

## Events Triggering Notifications

| **Event**                    | **Triggered When**                                                         |
|--------------------------------|----------------------------------------------------------------------------|
| Push to Repository            | New code is pushed to any branch.                                           |
| Merge Request Opened          | A user creates a merge request for code review.                             |
| Merge Request Approved        | A reviewer approves the code changes.                                       |
| Merge Request Merged          | Code is merged into the main branch.                                         |
| Pipeline Started/Passed/Failed| CI/CD pipelines start, succeed, or fail.                                    |
| Issue Created or Updated      | New issues are reported or existing issues are updated.                    |
| New Tag/Release Created       | A new release version is tagged or announced.                               |
| User Role Updated             | A user gains or loses repository access.                                    |
| Security Vulnerability Found  | Code scanning detects vulnerabilities or problems.                         |

---

## Notification Delivery Channels

| **Channel**                | **Use Case**                                                               |
|------------------------------|-----------------------------------------------------------------------------|
| Email Notifications         | Daily or instant updates for code, pipelines, and issues.                  |
| Slack / Microsoft Teams Alerts | Real-time updates for fast-moving team activities.                     |
| Webhooks                    | Trigger external systems like Jenkins, Jira, etc.                           |
| Mobile Push Notifications    | Notify users immediately via mobile apps.                                  |
| In-App Notifications         | Alerts shown inside the VCS platform (e.g., GitLab, GitHub dashboard).      |

---

## Conclusion

This document explained the notification strategy in Version Control Systems (VCS), highlighting why notifications are important, which events trigger them, who relies on them, and how they are delivered. A clear notification system ensures that the right stakeholders are informed at the right time, enabling smooth collaboration, faster response to issues, and better project tracking across the development lifecycle.

---

## **Contact Information**

| **Name**        | **Email Address**                          |
|-----------------|--------------------------------------------|
| Prince Batra    | prince.batra.snaatak@mygurukulam.co        |

---

## References

| **Title**                         | **Link**                                                                                   | **Summary**                                                                 |
|----------------------------------|---------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| GitLab Notifications             | [Visit](https://docs.gitlab.com/ee/user/profile/notifications.html)                        | How GitLab handles notifications for users and groups.                      |
| GitHub Notifications             | [Visit](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github) | Setting up and managing notifications on GitHub.                            |
| GitLab Webhooks                  | [Visit](https://docs.gitlab.com/ee/user/project/integrations/webhooks.html)                 | Sending GitLab events to external services using webhooks.                  |
