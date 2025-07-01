# Infrastructure Monitoring – Key Metrics & Requirements

<p align="center">
  <img src="https://img.freepik.com/premium-vector/system-monitoring-icon_23785-2166.jpg?w=826" width="300"/>
</p>

## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer         |
| ---------- | ------------ | ------- | ------------ | --------------- | ---------------- |
| 01-07-2025 | 01-07-2025   | V1.0    | Prince Batra | Internal Review | Komal Jaiswal |
| 01-07-2025 | 01-07-2025   | V1.0    | Prince Batra | Internal Review | Shreya Jaiswal |
| 01-07-2025 | 01-07-2025   | V1.0    | Prince Batra | Internal Review | Kirti Nehra |

---

## **Table of Contents**

1. [What is Infrastructure Monitoring?](#what-is-infrastructure-monitoring)
2. [Why Should You Monitor Infrastructure?](#why-should-you-monitor-infrastructure)
3. [Key Performance Metrics](#key-performance-metrics)
4. [Metric Thresholds & Requirements](#metric-thresholds--requirements)
5. [Monitoring Requirements & Tools](#monitoring-requirements--tools)
6. [Conclusion](#conclusion)
7. [Contact Information](#contact-information)
8. [Reference Table](#reference-table)

---

## What is Infrastructure Monitoring?

This document defines Infrastructure Monitoring as the continuous tracking of system metrics like CPU, memory, disk, and network to ensure server health and performance. It enables early detection of issues, supports incident response, and helps with capacity planning. The setup uses Prometheus, Node Exporter, and Grafana.

---

## Why Should You Monitor Infrastructure?

| Reason                        | Explanation                                                               |
| ----------------------------- | ------------------------------------------------------------------------- |
| **Early Problem Detection**   | Prevent outages by identifying abnormal CPU, memory, or disk usage early. |
| **Capacity Planning**         | Helps anticipate infrastructure scaling needs before hitting limits.      |
| **Performance Optimization**  | Enables resource tuning for efficient usage.                              |
| **Incident Response & RCA**   | Provides real-time and historical data for troubleshooting issues.        |
| **Compliance & SLA Tracking** | Ensures infrastructure meets agreed performance standards.                |

---

## Key Performance Metrics

| Metric Category              | Metric Name              | Description                                                                |
| ---------------------------- | ------------------------ | -------------------------------------------------------------------------- |
| **CPU**                      | CPU usage %              | Total CPU utilization across all cores. High values may signal overload.   |
| **Memory**                   | Used Memory %            | RAM usage excluding cached/buffered memory. Helps spot memory pressure.    |
| **Swap Usage**               | Swap used %              | Indicates RAM exhaustion if swap is heavily used.                          |
| **Disk Usage**               | Filesystem usage %       | Space utilization for critical partitions like `/`, `/var`, `/data`.       |
| **Disk I/O**                 | Read/write rate, IOPS    | Throughput and I/O latency on disks. Important for DB and storage servers. |
| **Network**                  | Ingress/Egress (bps/pps) | Tracks network usage, errors, drops, and congestion.                       |
| **System Load**              | 1m / 5m / 15m Load Avg   | Load relative to CPU cores. Load > cores suggests system stress.           |
| **Uptime**                   | Time since last boot     | Helps track reboot patterns and ensure availability.                       |
| **Process Check (optional)** | Process up/down          | Optional for services like Jenkins or SonarQube; verify process is alive.  |

---

## Metric Thresholds & Requirements

| Metric                | Warning Threshold    | Critical Threshold  | Action Needed                  |
| --------------------- | -------------------- | ------------------- | ------------------------------ |
| CPU Usage %           | > 70% for 5 min      | > 90% for 5 min     | Investigate top processes      |
| Memory Usage %        | > 75%                | > 90%               | Optimize or scale memory       |
| Swap Usage %          | > 20%                | > 50%               | Indicates memory exhaustion    |
| Disk Usage %          | > 70%                | > 90%               | Clean logs or expand volumes   |
| Disk I/O Wait %       | > 10%                | > 25%               | Check for disk bottlenecks     |
| Network Errors        | > 0.5%               | > 2%                | Inspect interfaces and cabling |
| Load Average (1 min)  | > 1× core count      | > 2× core count     | Check CPU/memory bottlenecks   |
| Uptime                | < 1 day (unexpected) | < 1 hr              | Investigate sudden reboots     |
| Critical Process Down | -                    | Process not running | Restart or raise incident      |

---

## Monitoring Requirements & Tools

| Component                  | Tool Used       | Description                                        |
| -------------------------- | --------------- | -------------------------------------------------- |
| **Metric Collection**      | Prometheus      | Pulls metrics from exporters at regular intervals. |
| **System Exporter**        | Node Exporter   | Installed on each server to expose infra metrics.  |
| **Visualization**          | Grafana         | Used to design custom dashboards for all metrics.  |
| **Storage**                | Prometheus TSDB | Retains time series data for alerting and RCA.     |
| **Alerting (future task)** | Alertmanager    | Will trigger alerts on threshold breaches.         |

---

## Conclusion

This document highlights the role of Infrastructure Monitoring in tracking system metrics like CPU, memory, disk, and network. It enables early issue detection and ensures server performance and availability. The setup uses Prometheus, Node Exporter, and Grafana.

---

## **Contact Information**

| **Name**         | **Email Address**                                                                 |
| ---------------- | --------------------------------------------------------------------------------- |
| **Prince Batra** | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## **Reference Table**

| **Links**                                                                        | **Overview**                                           |
| -------------------------------------------------------------------------------- | ------------------------------------------------------ |
| [Prometheus](https://prometheus.io)                                              | Official website for Prometheus monitoring system.     |
| [Node Exporter](https://github.com/prometheus/node_exporter)                     | Exporter for system-level metrics in Linux.            |
| [Grafana](https://grafana.com)                                                   | Tool for building metric dashboards.                   |
| [Prometheus Alerting](https://prometheus.io/docs/alerting/latest/alertmanager/)  | Guide for configuring alerting rules and Alertmanager. |
| [Linux Load Average](https://www.tecmint.com/understand-load-averages-in-linux/) | Understanding system load metrics.                     |
