# **Infrastructure Monitoring POC – Prometheus + Grafana**

<p align="center">
  <img src="https://shalb.com/wp-content/uploads/2022/09/Grafana.png" width="600"/>
</p>

## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer |
| ---------- | ------------ | ------- | ------------ | --------------- | -------- |
| 07‑07‑2025 | 07‑07‑2025   | V1.0    | Prince Batra | Internal Review | Aman     |
| 07‑07‑2025 | 07‑07‑2025   | V1.0    | Prince Batra | L0 Review       | Shikha        |
| 07‑07‑2025 | 07‑07‑2025   | V1.0    | Prince Batra | L1 Review       | Kirti Nehra   |

---

## Table of Contents

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Step‑by‑Step Instructions](#step-by-step-instructions)

  * [Step 1 – Install components](#step-1)
  * [Step 2 – Point Prometheus at Node Exporter](#step-2)
  * [Step 3 – Add alert rules](#step-3)
  * [Step 4 – Configure Alertmanager email](#step-4)
  * [Step 5 – Add Prometheus data‑source to Grafana](#step-5)
  * [Step 6 – Create CPU + Memory dashboard](#step-6)
* [Triggering a test alert](#triggering-a-test-alert)
* [Conclusion](#conclusion)
* [Reference Table](#reference-table)

---

## Introduction

This POC demonstrates end-to-end infrastructure monitoring using Prometheus, Grafana, Alertmanager, and Node Exporter. It enables real-time metric collection, visualization through dashboards, and alerting based on defined thresholds. The setup helps ensure system reliability and timely incident response.

---

## Prerequisites

| Item                                      | Details                                     |
| ----------------------------------------- | ------------------------------------------- |
| Monitoring Server                         | Prometheus, Grafana, Alertmanager installed |
| Target Server                             | Node Exporter installed                     |
| Outbound SMTP (Port 587) for Gmail alerts | App Password recommended with 2FA       |

---

## Step‑by‑Step Instructions

<a id="step-1"></a>

### **Step 1: Check Versions and Install if Not Installed**

```bash
prometheus --version
alertmanager --version
grafana-server -v
```
![image](https://github.com/user-attachments/assets/09973319-35cf-47ba-a811-3b26f82a360e)

---

<a id="step-2"></a>

### **Step 2 – Point Prometheus at Node Exporter**

```bash
/etc/prometheus/prometheus.yml
```

![image](https://github.com/user-attachments/assets/a6cb3d56-a265-4433-ae82-9a7fed0cd7c7)

* Make sure node exporter is installed on target server
---

<a id="step-3"></a>

### **Step 3 – Add alert rules**

```bash
/etc/prometheus/rules.yml
```

![image](https://github.com/user-attachments/assets/3c9c3410-19d7-4f40-9760-3be470b10fde)

---

<a id="step-4"></a>

### **Step 4 – Configure Alertmanager email**

```bash
/etc/alertmanager/alertmanager.yml
```

![image](https://github.com/user-attachments/assets/cfacafbe-e575-4152-805d-886c4c519fe0)

---

<a id="step-5"></a>

### **Step 5 – Add Prometheus to Grafana**

1. Open `<<private-ip>>:3000` → login `admin / admin`.
2. **Gear icon ▸ Data Sources ▸ Add ➜ Prometheus**
   *URL:* `<<private-ip>>:9090` → **Save & Test**.

---

<a id="step-6"></a>

### **Step 6 – Create CPU & Memory dashboard**

| Panel                         | Query (Code mode)                                                                                | Unit | Thresholds |
| ----------------------------- | ------------------------------------------------------------------------------------------------ | ---- | ---------- |
| **CPU Usage %** (Time series) | `100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m]))*100)`                    | %    | 70 / 90    |
| **Memory Usage %** (Gauge)    | `((node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes)/node_memory_MemTotal_bytes)*100` | %    | 75 / 90    |

Set **Min 0 / Max 100** and Legend `{{instance}}`.

---

## Triggering a Test Alert

SSH into `54.166.11.3` and run:

```bash
sudo apt-get install -y stress
stress --cpu $(nproc) --timeout 360   # load >90 % for 6 min
```

After 5 min:

* Prometheus ▸ `/alerts` → `CPUUsageCritical` = **Firing**
* Alertmanager UI shows alert and email is sent.

Stop load:

```bash
pkill stress
```

Alert resolves and email “Resolved” message arrives.

---

## Conclusion

This POC demonstrates full flow:

1. **Collection** – Node Exporter → Prometheus
2. **Alerting** – Prometheus rules → Alertmanager email
3. **Visualisation** – Grafana dashboard (CPU, Memory)

Adapt the same pattern for Disk, Network, Load, and Uptime using the queries & thresholds table.

---

## Reference Table

| Link              | Purpose                         |
| ----------------- | ------------------------------- |
| Prometheus Docs   | Metric collection & alert rules |
| Grafana Docs      | Dashboard creation              |
| Alertmanager Docs | Email / Slack routing           |

Feel free to copy, tweak thresholds, or extend to other metrics.
