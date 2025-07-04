# Canary Deployment – Immutable Infra Rollout

<div align="center">
  <img width="600" height="250" alt="Canary‑Flow" src="https://martinfowler.com/bliki/images/canaryRelease/canary-release-2.png">
</div>

## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer      |
| ---------- | ------------ | ------- | ------------ | --------------- | ------------- |
| 04-07-2025 | 04-07-2025   | V1.0    | Prince Batra | Internal Review | Komal Jaiswal |
| 04-07-2025 | 04-07-2025   | V1.0    | Prince Batra | L0 Review       | Shikha        |
| 04-07-2025 | 04-07-2025   | V1.0    | Prince Batra | L1 Review       | Kirti Nehra   |

---

## **Table of Contents**

1. [Introduction](#introduction)
2. [Flow Diagram](#flow-diagram)
3. [Terraform Approach](#terraform-approach)
4. [Canary Deployment Steps](#canary-deployment-steps)
5. [Conclusion](#conclusion)
6. [References](#references)

---

## Introduction

This document serves as a Proof of Concept (PoC) for implementing a Canary Deployment using Terraform. It demonstrates how infrastructure can be provisioned using Infrastructure as Code (IaC) to enable safe, staged rollouts of application updates.

---

## Flow Diagram

```mermaid
flowchart TD
  A[Create AMIs for v1 and v2] --> B[Create Target Groups]
  B --> C[Create Launch Templates]
  C --> D[Create Auto Scaling Groups]
  D --> E[ALB with 90/10 traffic split]
  E --> F[Monitor v2 Health]
  F --> G{Is v2 Healthy?}
  G -- Yes --> H[Shift All Traffic to v2]
  G -- No  --> I[Destroy v2 Resources]

```

---

## Terraform Approach

### **Step-by-Step Infra Workflow**

1. **Create AMIs**

   * `ami_v1` → Application version v1
   * `ami_v2` → Application version v2

2. **Create Target Groups**

   * `canary-tg-v1` for v1 instances
   * `canary-tg-v2` for v2 instances

3. **Create Launch Templates**

   * `canary-lt-v1` → Uses `ami-v1`
   * `canary-lt-v2` → Uses `ami-v2`

4. **Create Auto Scaling Groups**

   * `canary-asg-v1` → Uses `canary-lt-v1`, size defined via `v1_count`
   * `canary-asg-v2` → Uses `canary-lt-v2`, size defined via `v2_count`
   * Both ASGs run in **public subnets**

5. **Create ALB and Listener**

   * One ALB with listener on port 80
   * Forwards traffic using weighted routing:

     * `canary-tg-v1`: 90%
     * `canary-tg-v2`: 10%

---

## Canary Deployment Steps

* Two ASGs: one for `v1`, one for `v2`

![image](https://github.com/user-attachments/assets/91ff3b7f-6e38-42da-8eb3-0e98883754f2)

* Two target groups

![image](https://github.com/user-attachments/assets/c582a584-31a0-4e73-acab-19eb20dd3f0c)

* ALB with 90/10 traffic split

![image](https://github.com/user-attachments/assets/2ad3dc52-1730-4ad5-bab6-221bbc2f7f44)

* The canary deployment serves v2 to a limited subset of users while maintaining v1 for most traffic, enabling safe incremental rollout.

![image](https://github.com/user-attachments/assets/1b101ab9-32c0-4716-932c-3c760d67fc29)

![image](https://github.com/user-attachments/assets/ca2976bb-6e88-408e-85d1-765ea370a324)

* Monitor logs, metrics, health of `v2`, If healthy, adjust weights to shift traffic to `v2`

 ![image](https://github.com/user-attachments/assets/e461a96b-2fb7-468e-b277-dbf722cb3922)
 
* If not, destroy `v2` ASG and TG

Rollback `v2`:

```bash
terraform destroy -target=aws_autoscaling_group.asg_v2 -target=aws_lb_target_group.tg_v2
```

---

## **Conclusion**

This document demonstrates a canary deployment using Terraform to safely roll out version v2 alongside v1. By routing 10% traffic to v2, issues can be identified early before full promotion. It ensures safer, controlled, and auditable infrastructure rollout.

---

## **Contact Information**

| Name         | Email Address                                                                     |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## **References**

| Title                          | Link                                                                                                                                                                             |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Terraform AWS Provider         | [https://registry.terraform.io/providers/hashicorp/aws/latest/docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)                                           |
| AWS Canary Deployment          | [https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html) |
| Canary Testing - Martin Fowler | [https://martinfowler.com/bliki/CanaryRelease.html](https://martinfowler.com/bliki/CanaryRelease.html)                                                                           |
