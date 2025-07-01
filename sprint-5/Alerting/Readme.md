# Infrastructure Monitoring – Alerting Rules & Process

<p align="center">
  <img src="https://earthly.dev/blog/assets/images/aws-cloudwatch/alarm.png?w=826" width="300"/>
</p>

## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer      |
| ---------- | ------------ | ------- | ------------ | --------------- | ------------- |
| 01‑07‑2025 | 01‑07‑2025   | V1.0    | Prince Batra | Internal Review | Komal Jaiswal |
| 01‑07‑2025 | 01‑07‑2025   | V1.0    | Prince Batra | L0 Review       | Shikha        |
| 01‑07‑2025 | 01‑07‑2025   | V1.0    | Prince Batra | L1 Review       | Kirti Nehra   |

---

## **Table of Contents**

1. [What is Alerting in Infrastructure Monitoring?](#what-is-alerting-in-infrastructure-monitoring)
2. [Alerting Rules Configuration](#alerting-rules-configuration)
3. [Severity Levels](#severity-levels)
4. [Notification Channels](#notification-channels)
5. [End‑to‑End Alert Handling Process](#end-to-end-alert-handling-process)
6. [Conclusion](#conclusion)
7. [Contact Information](#contact-information)
8. [Reference Table](#reference-table)

---

## What is Alerting in Infrastructure Monitoring?

This document states that alerting is the automatic process of generating notifications whenever monitored metrics cross predefined thresholds. Using **Prometheus Alertmanager**, these alerts are routed to the right people or systems so they can act quickly, maintain uptime, and meet SLAs.

---

## Alerting Rules Configuration

| Metric (PromQL Basis) | Warning Condition | Critical Condition | Rule Name        |
| --------------------- | ----------------- | ------------------ | ---------------- |
| CPU Usage %           | > 70 % for 5 m    | > 90 % for 5 m     | HighCPUUsage     |
| Memory Usage %        | > 75 % for 5 m    | > 90 % for 5 m     | HighMemoryUsage  |
| Swap Usage %          | > 20 % for 10 m   | > 50 % for 10 m    | HighSwapUsage    |
| Disk Usage %          | > 70 %            | > 90 %             | LowDiskSpace     |
| Disk I/O Wait %       | > 10 % for 5 m    | > 25 % for 5 m     | HighDiskIOWait   |
| Network Errors %      | > 0.5 % for 5 m   | > 2 % for 5 m      | NetworkErrors    |
| Load Avg / Core       | > 1  for 5 m      | > 2  for 5 m       | HighSystemLoad   |
| Uptime (Unexpected)   | —                 | < 1 h              | UnexpectedReboot |
| Critical Process Down | —                 | Process = 0        | ProcessDown      |

**Sample rule file (Prometheus YAML extract)**

```yaml
groups:
- name: infra.rules
  rules:
  - alert: HighCPUUsage
    expr: (1 - avg by(instance)(irate(node_cpu_seconds_total{mode="idle"}[5m]))) * 100 > 90
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "CPU >90% on {{ $labels.instance }}"
```

---

## Severity Levels

| Level        | Meaning                              | Example Rules                    | Target Response Time |
| ------------ | ------------------------------------ | -------------------------------- | -------------------- |
| **Critical** | Immediate action; risk of outage     | `HighCPUUsage`, `ProcessDown`    | 15 min (PagerDuty)   |
| **Warning**  | Needs attention soon; degrade likely | `HighSwapUsage`, `Disk I/O Wait` | 1 h (Slack)          |
| **Info**     | Informational; no direct action      | Deployment annotations           | As needed            |

---

## Notification Channels

| Channel                 | Used For                   | Tool / Route                 |
| ----------------------- | -------------------------- | ---------------------------- |
| **PagerDuty**           | Critical alerts            | 24×7 on‑call rotation        |
| **Slack #infra-alerts** | Warning alerts, summaries  | Alertmanager webhook → Slack |
| **Email Ops DL**        | Info alerts, daily digests | Alertmanager email receiver  |

Routing is managed in **Alertmanager** YAML with `receiver` and `route` blocks mapping severity to channels.

---

## End‑to‑End Alert Handling Process

| Step | Action                                             | Owner               |
| ---- | -------------------------------------------------- | ------------------- |
| 1    | Alert fires in Prometheus rule engine              | Prometheus          |
| 2    | Alertmanager receives, adds labels, groups         | Alertmanager        |
| 3    | Notification sent to channel based on severity     | Alertmanager        |
| 4    | On‑call engineer acknowledges / silences if needed | On‑call Engineer    |
| 5    | Root‑cause analysis & remediation                  | Infra Team          |
| 6    | Post‑incident review (if Critical)                 | Team + Stakeholders |
| 7    | Update thresholds/runbook if required              | Infra Team          |

---

## Conclusion

This document details the **alerting rules configuration**, **severity mapping**, **notification channels**, and the **end‑to‑end alert handling process** for infrastructure monitoring. By aligning rule thresholds with defined metrics, and routing notifications via Alertmanager, teams can react swiftly, minimise downtime, and continuously improve operational reliability.

---

## **Contact Information**

| Name         | Email                                                                             |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## **Reference Table**

| **Links**                                                                                             | **Overview**                                |
| ----------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Prometheus Alerting Docs](https://prometheus.io/docs/alerting/latest/overview/)                      | Configuration guide for alert rules         |
| [Alertmanager Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)                         | Routing and receiver configuration          |
| [PagerDuty Integration](https://prometheus.io/docs/alerting/latest/notification_examples/)            | Example setup with PagerDuty                |

