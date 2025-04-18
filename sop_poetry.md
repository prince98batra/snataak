<p align="center">
  <img src="https://th.bing.com/th/id/OIP.u0ITNfG1tfzVyuLcZWPWTAHaD4?w=343&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7" alt="image" width="400"/>
</p>

# SOP: Python Poetry

## **Author Information**
| **Created**       | **Version** | **Last Modified** | **Author**        | **Level**            | **Reviewer**  |
|--------------------|-------------|-------------------|-------------------|------------------------|---------------|
| 15-04-2025         | V1          | 15-04-2025        | Prince Batra    | Internal review        | Siddharth Pawar        |
| 15-04-2025         | V2          | 17-04-2025        | Prince Batra      | L0 Review | Shikha        |

---

## Table of Contents

- [Introduction](#1-introduction)  
- [Prerequisites](#2-prerequisites)  
- [Step-by-Step Instructions](#3-step-by-step-instructions)  
  - [Step 1: Install Python & pip (If not already installed)](#step-1-install-python--pip-if-not-already-installed)  
    - [Step 1.1: System Update Command](#step-11-system-update-command)  
    - [Step 1.2: Install Python-3](#step-12-install-python-3)  
  - [Step 3: Install Poetry](#step-3-install-poetry)  
  - [Step 4: Create a New Poetry Project](#step-4-create-a-new-poetry-project)  
  - [Step 5: Create & Activate Virtual Environment](#step-5-create--activate-virtual-environment)  
  - [Step 6: Add Dependencies](#step-6-add-dependencies)  
  - [Step 7: Create a Simple Python Script (`cart.py`)](#step-7-create-a-simple-python-script-cartpy)  
  - [Step 8: Run the Script Using Poetry (Running in Context)](#step-8-run-the-script-using-poetry-running-in-context)  
- [Conclusion](#4-conclusion)  
- [Contact Information](#contact-information)  
- [Reference Table](#reference-table)

---

## 1. Introduction

**Poetry** is a simple, all-in-one tool for managing Python projects, dependencies, and environments—making setup and collaboration easy and consistent.

---

## 2. Prerequisites  
- Python 3.x and pip installed on the system
  
---

## 3. Step-by-Step Instructions  

### Step 1: Install Python & pip (If not already installed)

> 1️⃣ **Step 1.1: System Update Command**  
> Before proceeding, it's **highly recommended** to follow the update instructions from the official documentation.  
> 👉 **Follow Step 3 here**: [Ubuntu Basic System Commands](https://github.com/snaatak-Downtime-Crew/Documentation/blob/durgesh_scrums_3/common_stack/operating_system/ubuntu/sop/commoncommands/README.md#1-basic-system-commands)
>
> ---
>
> 2️⃣ **Step 1.2: Install Python-3**  
> 👉 **Follow Step 3 & 4 here**: [Python3 & python3-pip Installation Commands](https://github.com/snaatak-Downtime-Crew/Documentation/blob/adil_scrums_11/common_stack/application/python/installation/guide/READEME.md#step-3-install-python3)
>
> ---

### Step 3: Install Poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

To make Poetry available in your terminal session, update your shell configuration:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
poetry --version
```

This installs Poetry and adds it to your system's PATH.

### Step 4: Create a New Poetry Project

```bash
poetry new my_project
cd my_project
```

This command will create a new project structure with:
- `pyproject.toml`: The file that manages dependencies.
- `my_project/`: Folder for your Python package.
- `tests/`: Folder for unit tests.

### Step 5: Create & Activate Virtual Environment

```bash
poetry env use python3
poetry env info
```

To manually activate the environment, run:

```bash
source $(poetry env info --path)/bin/activate
```

This step sets up a virtual environment isolated from your global Python environment.

### Step 6: Add Dependencies

```bash
poetry add requests pandas flask
```

This command will add requests, pandas, and flask to your project. The dependencies will appear in the pyproject.toml file under the [tool.poetry.dependencies] section:

```toml
[tool.poetry.dependencies]
requests = "^2.31.0"
pandas = "^2.2.1"
flask = "^2.3.0"
```

Poetry will also create or update the poetry.lock file to ensure the same package versions are used everywhere.

### Step 7: Create a Simple Python Script (`cart.py`)

```bash
nano cart.py
```

Paste the following code into the `cart.py` file:

```python
def calculate_total():
    cart = {
        "milk": 55,
        "bread": 40,
        "eggs": 75
    }
    total = sum(cart.values())
    print(f"Total grocery bill is: ₹{total}")

if __name__ == "__main__":
    calculate_total()
```

This script calculates the total cost of grocery items and prints the bill in Indian Rupees (₹).

### Step 8: Run the Script Using Poetry (Running in Context)

```bash
poetry run python cart.py
```

Expected output:

```bash
Total grocery bill is: ₹170
```

Running the script with `poetry run` ensures it uses the isolated virtual environment rather than your system's Python.

---

## 4. Conclusion
Poetry simplifies Python project management and is perfect for beginners and teams. It keeps dependencies and environments isolated, reducing bugs and setup issues. If you’re starting a new project, always prefer using Poetry for a clean, maintainable structure.

---

## **Contact Information**
| **Name** | **Email Address**        |
|----------|--------------------------|
| **Prince Batra**  | **prince.batra.snaatak@mygurukulam.co**   |

---

## **Reference Table**
| **Links** | **Overview** |
|---------------|-------------|
| [Poetry Docs](https://python-poetry.org/docs/) | Guides on using Poetry for dependency management, publishing, and configuration. |
| [Poetry GitHub](https://github.com/python-poetry/poetry) | The source code and issue tracker for Poetry. Useful for devs or contributors. |
| [PEP 518](https://peps.python.org/pep-0518/) | The PEP introducing the `pyproject.toml` standard for Python build systems. |

---
