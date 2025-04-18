<p align="center">
  <img src="https://maven.apache.org/images/maven-logo-black-on-white.png" alt="Apache Maven Logo" width="250"/>
</p>

# SOP: Maven Common & Debugging Commands

## **Author Information**
| **Created**       | **Version** | **Last Modified** | **Author**        | **Level**            | **Reviewer**  |
|--------------------|-------------|-------------------|-------------------|------------------------|---------------|
| 14-04-2025         | V1          | 14-04-2025        | Prince Batra    | Internal review        | Siddharth Pawar        |
| 14-04-2025         | V2          | 17-04-2025        | Prince Batra      | L0 Review | Shikha        |

---

## Table of Contents

1. [Introduction](#1-introduction)    
2. [Prerequisites ](#2-prerequisites)  
3. [Commonly Used Maven Commands](#3-commonly-used-maven-commands)
4. [Debugging & Troubleshooting Commands](#4-debugging--troubleshooting-commands)
5. [Conclusion](#5-conclusion)
6. [Contact Information](#contact-information)
7. [Reference Table](#reference-table)


---

## 1. Introduction

This SOP provides a quick reference to the most commonly used Maven commands and debugging techniques for Java developers. It is meant to simplify daily development tasks such as building, testing, and troubleshooting Maven-based projects in local environments.

---

## 2. Prerequisites

### Step 1: Install Java (JDK 11 or higher)

>  **Follow Steps here**: [Ubuntu Basic System Commands](https://github.com/snaatak-Downtime-Crew/Documentation/blob/harsh_scrums_23/common_stack/application/java/installation/guide/README.md#java-installation-steps-ubuntu)
>
> ---


### Step 2: Install Maven and check version

```bash
sudo apt install maven -y
mvn -v
```

---

## **3. Commonly Used Maven Commands**

---

| **Task** | **Command** | **Expected Output** | **Purpose** | **When to Use** |
|------|-------------|---------------------|-------------|-----------------|
| 1. **Clean compiled files** | `mvn clean` | ```[INFO] Deleting /path/to/project/target```<br>```[INFO] BUILD SUCCESS``` | Removes the `target/` directory with old build files. | Before a fresh build to ensure no leftover files affect the process. |
| 2. **Compile the project** | `mvn compile` | ```[INFO] Compiling 1 source file to /path/to/project/target/classes```<br>```[INFO] BUILD SUCCESS``` | Converts source code into bytecode. | To check for compilation errors before testing or packaging. |
| 3. **Run unit tests** | `mvn test` | ```[INFO] Running com.example.projectname.TestClass```<br>```[INFO] Tests run: 5, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.012 sec```<br>```[INFO] BUILD SUCCESS``` | Runs test cases from `src/test/java` using test frameworks. | To verify if individual components are working correctly. |
| 4. **Create a JAR/WAR** | `mvn package` | ```[INFO] Building jar: /path/to/project/target/project-name-1.0-SNAPSHOT.jar```<br>```[INFO] BUILD SUCCESS``` | Packages compiled code into deployable artifacts like `.jar` or `.war`. | When preparing the application for deployment or delivery. |
| 5. **Install the Project Locally** | `mvn install` | ```[INFO] BUILD SUCCESS``` | Installs built artifact into your local Maven repository. | When you want the project available locally for use in other projects. |
| 6. **Deploying the Project** | `mvn deploy` | ```[INFO] BUILD SUCCESS``` | Uploads the artifact to a remote Maven repository. | When sharing the project with teams or external applications. |
| 7. **Validate the Project** | `mvn validate` | ```[INFO] BUILD SUCCESS``` | Verifies if project structure and dependencies are correctly set. | For checking proper project setup before proceeding. |
| 8. **Run integration tests** | `mvn verify` | ```[INFO] BUILD SUCCESS``` | Runs full test lifecycle including integration tests. | To ensure the system works as a whole before deployment. |
| 9. **Download all dependencies** | `mvn dependency:resolve` | ```[INFO] Downloaded: junit:junit:4.13.2```<br>```[INFO] BUILD SUCCESS``` | Fetches all libraries defined in `pom.xml`. | During initial setup or when dependencies fail to resolve. |
| 10. **Print all dependencies** | `mvn dependency:tree` | ```com.example.projectname:project-name:jar:1.0-SNAPSHOT```<br>```├── junit:junit:jar:4.13.2:test```<br>```└── org.springframework:spring-core:jar:5.3.8``` | Shows a tree of direct and transitive dependencies. | To inspect or debug library conflicts and structure. |
| 11. **Clean and build the project** | `mvn clean install` | ```[INFO] BUILD SUCCESS``` | Cleans old builds, compiles code, runs tests, installs locally. | For a full clean rebuild and local installation. |
| 12. **Skip tests during build** | `mvn install -DskipTests` | ```[INFO] Tests are skipped.```<br>```[INFO] BUILD SUCCESS``` | Builds and installs without running tests. | During quick development cycles (avoid for production builds). |
| 13. **Run a specific test** | `mvn -Dtest=ClassName test` | ```[INFO] Running com.example.projectname.TestClass```<br>```[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.005 sec```<br>```[INFO] BUILD SUCCESS``` | Runs only a specified test class or method. | When focusing on or debugging a particular test. |

---

## 4. Debugging & Troubleshooting Commands

| Task | Command | Expected Output | Purpose | When to Use |
|------|---------|-----------------|---------|-------------|
| 1. Enable Debugging Output | `mvn -X` | `[DEBUG] [INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ project-name ---`<br>`[DEBUG] [INFO] BUILD SUCCESS` | Shows detailed logs for the entire build process. | When builds fail and you need more context for debugging. |
| 2. Print the Final POM (Project Configuration) | `mvn help:effective-pom` | `[INFO] Scanning for projects...`<br>`[INFO] Effective POM for project project-name: 1.0-SNAPSHOT` | Shows complete effective project configuration. | To view all applied POM settings including inherited ones. |
| 3. Show Information About a Plugin | `mvn help:describe -Dplugin=<plugin-name> -Ddetail` | `[INFO] Describing plugin org.apache.maven.plugins:maven-clean-plugin:3.1.0` | Describes usage, goals, and config of a specific plugin. | When understanding or troubleshooting Maven plugins. |
| 4. Force Maven to Update Dependencies | `mvn clean install -U` | `[INFO] BUILD SUCCESS` | Downloads the latest versions of dependencies, even if already cached locally. | When your project uses outdated libraries or new versions are not picked up |
| 5. Check Your Maven Version | `mvn -v` | `Apache Maven 3.6.3`<br>`Maven home: /path/to/maven`<br>`Java version: 1.8.0_252, vendor: Oracle Corporation` | Shows your Maven and Java versions. | To confirm installed versions or check compatibility issues. |
| 6. Show Effective Settings | `mvn help:effective-settings` | `[INFO] Effective settings for Maven` | Displays the final settings Maven uses (default + custom) | For debugging settings or verifying profile configurations.

---

## 5. Conclusion
Maven makes it easier to build, test, and manage Java projects.
With the commands and tips in this guide, you can quickly handle daily tasks and fix common issues.

---

## **Contact Information**
| **Name** | **Email Address**        |
|----------|--------------------------|
| **Prince Batra**  | **prince.batra.snaatak@mygurukulam.co**   |

---

## **Reference Table**

| **Links** | **Overview** |
|-----------|--------------|
| [Official Apache Maven Documentation](https://maven.apache.org/guides/index.html) | Central hub for all official Maven guides and documentation. |
| [Maven Lifecycle Reference](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html) | Explains Maven's build lifecycle phases and how they are structured. |
| [Maven Plugin Documentation](https://maven.apache.org/plugins/) | Index of official Maven plugins with usage details and configuration options. |
| [Effective POM and Settings](https://maven.apache.org/configure.html) | Covers configuration management via `pom.xml` and `settings.xml`. |

---
