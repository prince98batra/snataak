
# SOP: Python Poetry

![image](https://th.bing.com/th/id/OIP.u0ITNfG1tfzVyuLcZWPWTAHaD4?w=343&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7)

## 👤 **Author Information**
| **Created**       | **Version** | **Last Modified** | **Author**        | **Level**            | **Reviewer**  |
|--------------------|-------------|-------------------|-------------------|------------------------|---------------|
| 15-04-2025         | V1          | 15-04-2025        | Prince Batra    | Internal review        | Siddharth Pawar        |
| 15-04-2025         | V2          | 17-04-2025        | Prince Batra      | L0 Review | Shikha        |

---

## 📖 Table of Contents     
- [Introduction](#1-introduction)
- [Prerequisites](#4-prerequisites)
- [Step-by-Step Instructions](#5-step-by-step-instructions)  
  - [📍 Step 1: Install Python & pip](#-step-1-install-python--pip-if-not-already-installed)  
  - [📍 Step 2: Install Poetry](#-step-2-install-poetry)  
  - [📍 Step 3: Create a New Poetry Project](#-step-3-create-a-new-poetry-project)  
  - [📍 Step 4: Create & Activate Virtual Environment](#-step-4-create--activate-virtual-environment)  
  - [📍 Step 5: Add Dependencies](#-step-5-add-dependencies)  
  - [📍 Step 6: Create a Simple Python Script (`cartpy`)](#-step-6-create-a-simple-python-script-cartpy)  
  - [📍 Step 7: Run the Script Using Poetry](#-step-7-run-the-script-using-poetry-running-in-context)
- [Conclusion](#6-Conclusion)
- [Contact Information](#Contact-Information)
- [Reference Table](#Reference-table)
---

## 3. Why Use Poetry
Using Poetry saves time and avoids common mistakes:
- It automatically creates virtual environments so your system’s Python setup stays clean.
- It tracks your installed packages in one file (`pyproject.toml`) and locks their versions in `poetry.lock`.
- It helps you install, update, and remove packages easily.

---

## 4. Prerequisites  
- Python 3.x and pip installed on the system
  
---

## 5. Step-by-Step Instructions  

### 📍 Step 1: Install Python & pip (If not already installed)

**Follow Step 3 & 4 here**: [Python3 & python3-pip Installation Commands](https://github.com/snaatak-Downtime-Crew/Documentation/blob/adil_scrums_11/common_stack/application/python/installation/guide/READEME.md#step-3-install-python3)
This step ensures that Python 3 and pip are installed, which are required before installing Poetry.

### 📍 Step 2: Install Poetry

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

### 📍 Step 3: Create a New Poetry Project

```bash
poetry new my_project
cd my_project
```

This command will create a new project structure with:
- `pyproject.toml`: The file that manages dependencies.
- `my_project/`: Folder for your Python package.
- `tests/`: Folder for unit tests.

### 📍 Step 4: Create & Activate Virtual Environment

```bash
poetry env use python3
poetry env info
```

To manually activate the environment, run:

```bash
source $(poetry env info --path)/bin/activate
```

This step sets up a virtual environment isolated from your global Python environment.

### 📍 Step 5: Add Dependencies

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

### 📍 Step 6: Create a Simple Python Script (`cart.py`)

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

### 📍 Step 7: Run the Script Using Poetry (Running in Context)

```bash
poetry run python cart.py
```

Expected output:

```bash
Total grocery bill is: ₹170
```

Running the script with `poetry run` ensures it uses the isolated virtual environment rather than your system's Python.

---

## 6. Conclusion
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
