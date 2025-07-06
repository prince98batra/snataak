# **Terraform Unit Test POC**

<p align="center"> 
  <img src="https://github.com/user-attachments/assets/731fe4cd-9e32-4778-9b28-75f78237d19d" alt="Terraform Icon" width="200"/> 
</p>

## **Author Information**

| Created    | Last updated | Version | Author       | Level           | Reviewer      |
| ---------- | ------------ | ------- | ------------ | --------------- | ------------- |
| 06-07-2025 | 06-07-2025   | V1.0    | Prince Batra | Internal Review | Komal Jaiswal |
| 06-07-2025 | 06-07-2025   | V1.0    | Prince Batra | L0 Review       | Shikha        |
| 06-07-2025 | 06-07-2025   | V1.0    | Prince Batra | L1 Review       | Kirti Nehra   |

---

## Table of Contents

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Step-by-Step Instructions](#step-by-step-instructions)

  * [Step 1: Check Versions and Install if Not Installed](#step-1-check-versions-and-install-if-not-installed)
  * [Step 2: Initialize Go Module](#step-2-initialize-go-module)
  * [Step 3: Install Required Go Packages](#step-3-install-required-go-packages)
  * [Step 4: Tidy Up Go Modules](#step-4-tidy-up-go-modules)
  * [Step 5: Create Test Directory and Test File](#step-5-create-test-directory-and-test-file)
  * [Step 6: Add Go Test File](#step-6-add-go-test-file)
  * [Step 7: Run Unit Tests](#step-7-run-unit-tests)
* [Conclusion](#conclusion)
* [Contact Information](#contact-information)
* [Reference Table](#reference-table)

---

## Introduction

This POC demonstrates how to write and execute **unit tests for a Terraform module** using **Go** and the **Terratest** library. It ensures that your infrastructure code behaves as expected by validating resources through real-time interaction with cloud APIs.

---

## Prerequisites

* **Terraform module** should be present and ready for testing.
* **Go** and **Terraform** must be installed and configured.

---

## Step-by-Step Instructions

### Step 1: Check Versions and Install if Not Installed

```bash
go version         
terraform version  
```
![image](https://github.com/user-attachments/assets/1a65317b-f680-41e5-bf9c-be2725a543ac)

---

### Step 2: Initialize Go Module

Navigate to your Terraform module root directory and run:

```bash
go mod init s3
```
![image](https://github.com/user-attachments/assets/984de65d-bc7b-4720-ac5c-53910e79d520)

---

### Step 3: Install Required Go Packages

```bash
go get github.com/aws/aws-sdk-go/aws \
       github.com/aws/aws-sdk-go/service/s3 \
       github.com/gruntwork-io/terratest/modules/terraform \
       github.com/gruntwork-io/terratest/modules/aws \
       github.com/stretchr/testify/require
```
![image](https://github.com/user-attachments/assets/2f4951f4-452b-4f53-aa1c-e3deedb19893)

---

### Step 4: Tidy Up Go Modules

```bash
go mod tidy
```
![image](https://github.com/user-attachments/assets/9d46bd66-8e51-42a8-9329-ed3539262075)

This generates `go.sum` and removes unused packages.

---

### Step 5: Create Test Directory and Test File

```bash
mkdir -p test
touch test/s3_test.go
```

---

### Step 6: Add Go Test File

Paste the following into `test/s3_test.go`:

```go
package test

import (
        "context"
        "strings"
        "testing"

        "github.com/aws/aws-sdk-go/aws"
        "github.com/aws/aws-sdk-go/aws/session"
        "github.com/aws/aws-sdk-go/service/s3"
        "github.com/gruntwork-io/terratest/modules/terraform"
        "github.com/stretchr/testify/require"
)

func TestS3Bucket(t *testing.T) {
        t.Parallel()

        tf := &terraform.Options{
                TerraformDir: "..",
                Vars: map[string]interface{}{
                        "name": "prince-bucket-name",
                        "tags": map[string]string{
                                "Environment": "dev",
                                "Owner":       "Prince",
                        },
                },
        }

        defer terraform.Destroy(t, tf)
        terraform.InitAndApply(t, tf)

        bucket := terraform.Output(t, tf, "bucket_name")
        require.True(t, strings.HasPrefix(bucket, "prince-bucket-name-"))

        sess, err := session.NewSession(&aws.Config{Region: aws.String("us-east-1")})
        require.NoError(t, err)

        c := s3.New(sess)
        ctx := context.Background()

        _, err = c.HeadBucketWithContext(ctx, &s3.HeadBucketInput{Bucket: aws.String(bucket)})
        require.NoError(t, err)

        tagOut, err := c.GetBucketTaggingWithContext(ctx, &s3.GetBucketTaggingInput{Bucket: aws.String(bucket)})
        require.NoError(t, err)
        got := map[string]string{}
        for _, tg := range tagOut.TagSet {
                got[*tg.Key] = *tg.Value
        }
        require.Equal(t, "dev", got["Environment"])
        require.Equal(t, "Prince", got["Owner"])

        encOut, err := c.GetBucketEncryptionWithContext(ctx, &s3.GetBucketEncryptionInput{Bucket: aws.String(bucket)})
        require.NoError(t, err)
        require.Equal(t, "AES256",
                *encOut.ServerSideEncryptionConfiguration.Rules[0].
                        ApplyServerSideEncryptionByDefault.SSEAlgorithm)
}
```

---

### Step 7: Run Unit Tests

```bash
go test -v | grep -E "===|---|FAIL|PASS"
```
![image](https://github.com/user-attachments/assets/758a784a-08de-4db7-b12b-752a38780bde)

> The `grep` command filters out only key test output lines.
> To view full verbose test logs:

```bash
go test -v
```

---

## Conclusion

This POC provides a clear structure to implement unit testing in Terraform modules using **Go + Terratest**. Such tests help catch errors early by simulating real deployments and verifying AWS resource state, tags, encryption, and naming conventions. This approach is ideal for **CI/CD pipelines** and **production-grade Terraform modules**.

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
