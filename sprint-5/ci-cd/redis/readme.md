# Redis Monitoring – Alerting & Escalation Process

<div align="center">
  <img src="https://github.com/user-attachments/assets/90643981-aa08-4e17-8d5e-60ac1e3ea334" alt="Terraform CI Flow" width="300" height="200">
</div>

---

## Author Information

| Created | Version | Last Modified | Author | Comment | Reviewer |
| --- | --- | --- | --- | --- | --- |
| 03-07-2025 | V1 |     | Shivani Narula | Internal Review | Aman Raj |

---

## Table of Contents  
- [Overview](#overview)  
- [Monitoring Components](#monitoring-components)  
  - [Redis Monitoring Metrics](#redis-monitoring-metrics)  
- [Alert Severity Levels](#alert-severity-levels)  
- [Notification Channels](#notification-channels)  
- [Escalation Process](#escalation-process)  
  - [First-Level Escalation (L1)](#first-level-escalation-l1---on-call-engineer)  
  - [Second-Level Escalation (L2)](#second-level-escalation-l2---middleware-sme)  
  - [Third-Level Escalation (L3)](#third-level-escalation-l3---engineeringmanagement)  
- [Review & Continuous Improvement](#review--continuous-improvement)  
- [Contact Information](#contact-information)  
- [References](#references)  

---

## Overview  
This document defines the monitoring strategy, alert rules, severity levels, notification channels, and escalation process for Redis, which acts as a key middleware caching layer. The objective is to ensure early detection of performance issues and minimize downtime across environments.

---

## Monitoring Components

### Redis Monitoring Metrics  
Key metrics to monitor for Redis:  

| Metric               | Description                              | Alert Threshold                     |
|----------------------|-----------------------------------------|-------------------------------------|
| Memory Usage         | High memory consumption (>90%)          | `>90% of maxmemory`                 |
| CPU Utilization      | High CPU usage (>80%)                   | `>80% for 5 mins`                   |
| Latency              | Slow response times (>100ms avg)        | `>100ms for 5 mins`                 |
| Connections          | Too many open connections (>10k)        | `>10,000 connections`               |
| Replication Lag      | Slave lagging behind master (>10s)      | `>10s for 5 mins`                   |
| Key Evictions        | High rate of key evictions (>100/min)   | `>100 evictions/min`                |
| Failed Commands      | Command execution failures (>5/min)     | `>5 failures/min`                   |

---

## Alert Severity Levels

| Severity | Description                                                             | Example        |
| -------- | ----------------------------------------------------------------------- | -------------- |
| Critical | System outage or severe degradation requiring immediate action.         | CPU usage >90% |
| High     | Performance degradation or risk of failure; needs prompt investigation. | CPU usage >70% |
| Medium   | Non-critical issues that may impact performance if unaddressed.         | CPU usage >50% |
| Low      | Informational alerts for tracking or minor anomalies.                   | CPU usage >30% |

---

## Notification Channels  

| Channel               | Purpose                        | Tool/Integration             |
| --------------------- | ------------------------------ | ---------------------------- |
| Slack `#redis-alerts` | Real-time alerts & discussions | Integrated with Alertmanager |
| Email                 | Daily summary or escalations   | SMTP/Email relay             |
| Grafana Dashboard     | Visual monitoring & history    | Live dashboard & drilldowns  |

---

## Escalation Process

### First-Level Escalation (L1 - On-Call Engineer)  
- **Action**: Acknowledge alert, perform initial triage.  
- **Timeframe**:  
  - Critical: **5 mins**  
  - High: **15 mins**  
  - Medium: **1 hour**  

### Second-Level Escalation (L2 - Middleware SME)  
- **Trigger**: If unresolved after **30 mins (Critical)** or **2 hours (High)**.  
- **Action**: Deep dive into logs, apply fixes, coordinate with infra/database teams.  

### Third-Level Escalation (L3 - Engineering/Management)  
- **Trigger**: If issue persists beyond **1 hour (Critical)** or **4 hours (High)**.  
- **Action**: Major incident declared, war room initiated, post-mortem required.   

---

## Review & Continuous Improvement  
- Weekly review of false positives/negatives.  
- Quarterly updates to thresholds based on historical trends.  

---

## Contact Information  
| Name            | Email                                      |
|-----------------|--------------------------------------------|
| Shivani Narula | shivani.narula.snaatak@mygurukulam.co    |  

---

## References  
| Title                           | Link                                                       |
| ------------------------------- | ---------------------------------------------------------- |
| Redis Monitoring Best Practices | [Visit](https://www.groundcover.com/blog/monitor-redis)      |
| Grafana Alerts Documentation    | [Visit](https://grafana.com/docs/grafana/latest/alerting/) |
| Prometheus Redis Exporter       | [Visit](https://github.com/oliver006/redis_exporter)       |
