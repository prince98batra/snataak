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
  * [Step 6 – Create CPU & Memory dashboard](#step-6)
* [Conclusion](#conclusion)
* [Reference Table](#reference-table)
* 
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

## Step by Step Instructions

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

![image](https://github.com/user-attachments/assets/b08ae2ec-8b8e-4857-8aae-21fba3e37478)

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

1. Go to `http://<monitoring-ip>:3000`
2. Login: `admin / admin` (default)
3. Navigate to:

   * ⚙️ **Configuration** → **Data Sources**
   * Click **Add data source** → Select **Prometheus**
4. Set the URL to:

```
http://localhost:9090
```

---

<a id="step-6"></a>

### **Step 6 – Create CPU & Memory Dashboard**

| Panel                         | Query (Code mode)                                                                                | Unit | Thresholds |
| ----------------------------- | ------------------------------------------------------------------------------------------------ | ---- | ---------- |
| **CPU Usage %** (Time series) | (100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100))`                    | %    | 70 / 90    |

 In Grafana panel settings:
* Visualization → `Time Series` (for CPU)
* Unit → `%`
* Thresholds: set yellow at 70%, red at 90%
* Legend → `{{instance}}`
* Set **Min = 0**, **Max = 100** for clear display

![image](https://github.com/user-attachments/assets/e684ac5a-09ef-4aec-8922-79e21f807f5a)

---

## Verify if alert received or not after any event is triggered like cpu

After 5 min:

* Prometheus ▸ `/alerts` → `CPUUsageCritical` = **Firing**

![image](https://github.com/user-attachments/assets/922522e1-cfea-45cd-80f5-e2d69e5e0251)

* Alertmanager UI shows alert and email is sent.

![image](https://github.com/user-attachments/assets/eacf6710-f302-4f6f-aa72-607c12824b46)

Alert will also be received on email .

![image](https://github.com/user-attachments/assets/0ac0d116-d3e7-497f-b75c-08e65252a31e)

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
