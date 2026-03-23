# 🚀 Automated Serverless Portfolio & Visitor Counter

*A fully built serverless portfolio website with a live visitor counter that is deployed entirely through Infrastructure as Code.*

## 🛠️ Core Technologies

*   **Frontend:** HTML hosted on AWS S3 & CloudFront
*   **Backend API:** Python on AWS Lambda & HTTP API Gateway
*   **Database:** AWS DynamoDB
*   **Infrastructure as Code (IaC):** HashiCorp Terraform
*   **Cloud Provider:** Amazon Web Services (AWS)
*   **Tools:** AWS CLI, Git, macOS (zsh)

## 🧠 Project Purpose

The purpose of this project is to demonstrate serverless cloud computing practices whiich fully automate the deployment of a low-latency, highly available portfolio website. This portfolio website showcases key concepts that include:
*   **Serverless Compute & Database:** Managing live visitor data using AWS Lambda and DynamoDB.
*   **Infrastructure as Code:** Using declarative code to build our infrastructure.
*   **Principle of Least Privilege:** Using IAM Roles to restrict execution permissions to only tthose required.
*   **Secure Content Delivery:** Enforcing Origin Access Controls (OAC) to ensure S3 buckets are strictly private and all traffic routes securely through CloudFront CDN.

## 🏗️ Architecture Overview

```
[ Website Visitor ] 
       │
       ▼
 [ AWS CloudFront ] ──── (Static Assets) ────► [ AWS S3 Bucket ]
       │
 (API Request: GET /count)
       ▼
 [ API Gateway ]
       │
       ▼
 [ AWS Lambda ] (Python)
       │
 (UpdateItem / GetItem)
       ▼
 [ AWS DynamoDB ] (Atomic Counter)
```

## 🥞 Application Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend CDN** | AWS CloudFront |
| **Static Hosting** | AWS S3 Bucket |
| **API Routing** | AWS API Gateway |
| **Compute** | AWS Lambda (Python) |
| **Database** | AWS DynamoDB |
| **State Management** | S3 & DynamoDB |
| **Infrastructure** | Terraform  |

## 🗄️ Infrastructure Blueprint

```
AWS Cloud
├── Edge Layer
│   └── CloudFront Distribution
├── Storage Layer
│   └── S3 Bucket (HTML)
├── API Layer
│   └── API Gateway V2
├── Compute Layer
│   └── Lambda Function (Python App)
│       └── IAM Execution Role (Least Privilege)
├── Database Layer
│   └── DynamoDB Table (Visitor Count)
└── Terraform Management
    └── S3 / DynamoDB (Remote State Backend)
```

## 📂 Repository Structure

```
.
├── website/
│   ├── index.html              # Frontend
├── lambda/
│   ├── function.py             # Python script (boto3)
├── main.tf                     # Terraform folder
```

## 💻 Local Development & Deployment Commands

To deploy this serverless architecture on your own local computer, authenticate through AWS CLI (`aws configure`) and run:

```bash
# Initialize Terraform and download providers
terraform init

# Review execution plan to verify AWS resource additions
terraform plan

# Deploy the complete architecture
terraform apply
```
*Note: The script outputs the live HTTPS CloudFront URL directly in your console after completion which you can paste on your browser of choice to verify the live website.*

## ⚠️  Disclaimer!!

*This serverless portfolio is designed to demonstrate automated serverless architectural practices but AWS resources charge by usage eaning that you should ensure that after completion you use `terraform destroy` to prevent recurring unexpected billing on any of these resources utilised.*

## 🧑‍💻 Author

* **Name:** Peter Mkhatshwa
* **Focus:** Cloud Computing