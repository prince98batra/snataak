# AWS Cost Allocation Tags Document

<<p align="center">
  <img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" alt="AWS Logo" width="300"/>
</p>


## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer        |
| ---------- | ------------ | ------- | ------------ | --------------- | --------------- |
| 16-05-2025 | 16-05-2025   | V1    | Prince Batra | Internal Review | Siddharth Pawar |

---

## Table of Contents

- [Introduction](#introduction)
- [What Are AWS Cost Allocation Tags](#what-are-aws-cost-allocation-tags)
- [Why Use Cost Allocation Tags](#why-use-cost-allocation-tags)
- [Workflow Diagram](#workflow-diagram)
- [Advantages vs Disadvantages](#advantages-vs-disadvantages)
- [Best Practices](#best-practices)
- [Conclusion](#conclusion)
- [Contact Information](#contact-information)
- [Reference Table](#reference-table)

---

## Introduction

This SOP outlines the process and benefits of using AWS Cost Allocation Tags to improve visibility and manageability of cloud expenses. It is intended for teams across departments to ensure consistent tagging practices and better cost attribution within an AWS environment.

---

## What Are AWS Cost Allocation Tags

Cost Allocation Tags are key-value pairs assigned to AWS resources. These tags help categorize and track AWS costs by project, team, department, environment, or any custom criteria. There are two types:

* **AWS-Generated Tags**: Automatically created by AWS (e.g., `aws:createdBy`).
* **User-Defined Tags**: Custom tags created and applied by users (e.g., `Project:HRMS`, `Environment:Prod`).

Once enabled in the Billing and Cost Management Console, these tags appear in Cost Explorer and usage reports for better tracking and analysis.

---

## Why Use Cost Allocation Tags

Using Cost Allocation Tags enables organizations to:

* Identify which teams, projects, or products are incurring specific costs.
* Track resource usage across business units.
* Enable internal chargeback or showback processes.
* Detect cost anomalies quickly.
* Make data-driven decisions to optimize cloud usage and cost.

---

## Workflow Diagram

<p align="center">
  <img src="https://github.com/user-attachments/assets/4f251cd3-45fc-4e6d-9cfb-35fc2c23f422" alt="AWS Logo" width="600"/>
</p>


---

## Advantages vs Disadvantages

| **Advantages**                              | **Disadvantages**                               |
| ------------------------------------------- | ----------------------------------------------- |
| Enables detailed cost tracking and analysis | Tags must be applied consistently               |
| Helps set up internal chargeback mechanisms | Requires governance to avoid tag sprawl         |
| Improves budgeting and forecasting          | Some services may not fully support all tagging |
| Supports automation and policy enforcement  | Manual tagging can lead to human errors         |

---

## Best Practices

| **Practice**                          | **Description**                                                        |
| ------------------------------------- | ---------------------------------------------------------------------- |
| Use standard tag keys and values      | Define common formats like `Project`, `Owner`, `Environment`           |
| Enable tags in billing dashboard      | Only enabled tags will show up in cost reports                         |
| Automate tag application              | Use IaC (e.g., Terraform) or tagging policies to reduce human error    |
| Monitor for missing or incorrect tags | Set up regular audits using AWS Config or custom scripts               |
| Educate teams on tagging standards    | Ensure all resource creators understand and follow tagging conventions |

---

## Conclusion

This document explains the use of AWS Cost Allocation Tags to manage and track cloud costs. A proper tagging strategy ensures billing transparency and resource accountability. Following the recommended practices helps standardize tagging across the AWS environment.

---

## **Contact Information**

| **Name**     | **Email Address**                                                                 |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## **Reference Table**

| **Links**                                                                                                                     | **Overview**                                            |
| ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [AWS Tagging Best Practices](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)                                  | Official AWS documentation for tag naming and use cases |
| [Cost Allocation Tags - AWS Billing](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html)       | Guide to activate and use cost allocation tags          |
| [AWS Cost Explorer](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-what-is.html)                             | Visualize and analyze cost data using tags              |
