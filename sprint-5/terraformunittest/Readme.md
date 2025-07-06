# **Terraform Unit Test POC**

![icons8-terraform-240](https://github.com/user-attachments/assets/731fe4cd-9e32-4778-9b28-75f78237d19d)



## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer |
| ---------- | ------------ | ------- | ------------ | --------------- | -------- |
| 06-07-2025 | 06-07-2025   | V1.0    | Prince Batra | Internal Review | TBD      |

---

## Table of Contents

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Step-by-Step Instructions](#step-by-step-instructions)

  * [Step 1: Install Go and Terraform (if not already installed)](#step-1-install-go-and-terraform-if-not-already-installed)
  * [Step 2: Check Versions](#step-2-check-versions)
  * [Step 3: Initialize Go Module](#step-3-initialize-go-module)
  * [Step 4: Install Required Go Packages](#step-4-install-required-go-packages)
  * [Step 5: Tidy Up Go Modules](#step-5-tidy-up-go-modules)
  * [Step 6: Create Terraform and Test Directory Structure](#step-6-create-terraform-and-test-directory-structure)
  * [Step 7: Add Go Test File](#step-7-add-go-test-file)
  * [Step 8: Run Unit Tests](#step-8-run-unit-tests)
* [Conclusion](#conclusion)
* [Contact Information](#contact-information)
* [Reference Table](#reference-table)

---

## Introduction

This SOP explains how to write and execute **unit tests for Terraform** infrastructure using **Go** and **[Terratest](https://terratest.gruntwork.io/)**, a Go library for automated testing of infrastructure code.

---

## Prerequisites

* A Linux-based environment (or WSL for Windows users)
* Basic knowledge of Go and Terraform
* Terraform configuration already written (e.g., to create an S3 bucket)
* Internet access to download modules

---

## Step-by-Step Instructions

---

### Step 1: Install Go and Terraform (if not already installed)

```bash
# Install Go (Linux/WSL example)
sudo apt update
sudo apt install golang-go -y

# Install Terraform
sudo apt install unzip -y
wget https://releases.hashicorp.com/terraform/1.8.3/terraform_1.8.3_linux_amd64.zip
unzip terraform_1.8.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -version
```

---

### Step 2: Check Versions

```bash
go version         # Should be >= go1.23
terraform version  # Should be >= v1.3
```

---

### Step 3: Initialize Go Module

Navigate to your Terraform root directory (e.g., `~/terraform/s3`) and initialize a Go module:

```bash
cd ~/terraform/s3
go mod init s3-poc
```

---

### Step 4: Install Required Go Packages

```bash
go get github.com/aws/aws-sdk-go/aws \
       github.com/aws/aws-sdk-go/service/s3 \
       github.com/gruntwork-io/terratest/modules/terraform \
       github.com/gruntwork-io/terratest/modules/aws \
       github.com/stretchr/testify/require
```

> Terratest will automatically bump Go version to `go1.23` if required.

---

### Step 5: Tidy Up Go Modules

```bash
go mod tidy
```

This cleans up unused dependencies and generates a `go.sum` file for version locking.

---

### Step 6: Create Terraform and Test Directory Structure

Make sure you have a Terraform config (e.g., `main.tf`) to provision something like an S3 bucket.
Now create a test directory and Go test file:

```bash
mkdir test
touch test/s3_test.go
```

---

### Step 7: Add Go Test File

Paste the following into `test/s3_test.go`:

```go
package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/require"
    "github.com/gruntwork-io/terratest/modules/aws"
)

func TestS3Bucket(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        TerraformDir: "../",
    }

    defer terraform.Destroy(t, terraformOptions)

    terraform.InitAndApply(t, terraformOptions)

    bucketName := terraform.Output(t, terraformOptions, "bucket_name")
    region := terraform.Output(t, terraformOptions, "region")

    actualExists := aws.S3BucketExists(t, region, bucketName)
    require.True(t, actualExists, "Expected S3 bucket to exist")
}
```

> Ensure your Terraform config in `main.tf` has proper output variables `bucket_name` and `region`.

---

### Step 8: Run Unit Tests

```bash
go test -v ./test
```

> The `-v` flag enables verbose output. If you want less noise:

```bash
go test ./test
```

---

## Conclusion

Terratest makes it easy to test Terraform infrastructure with real deployments. This setup helps validate critical infrastructure changes and enforce correctness using Go's test framework.

Use this process whenever creating new infrastructure modules in Terraform, especially in CI pipelines.

---

## Contact Information

| **Name**     | **Email**                                                                         |
| ------------ | --------------------------------------------------------------------------------- |
| Prince Batra | [prince.batra.snaatak@mygurukulam.co](mailto:prince.batra.snaatak@mygurukulam.co) |

---

## Reference Table

| **Link**                                                         | **Description**                              |
| ---------------------------------------------------------------- | -------------------------------------------- |
| [Terratest Docs](https://terratest.gruntwork.io/)                | Official Terratest documentation             |
| [Go Official Docs](https://go.dev/doc/)                          | Learn more about the Go programming language |
| [Terraform Docs](https://developer.hashicorp.com/terraform/docs) | Complete Terraform documentation             |

---

Let me know if you want:

* A downloadable `.md` or `.pdf` version of this
* A reusable template format for future infra test POCs
* Integration with GitHub Actions for CI testing

Ready when you are.
