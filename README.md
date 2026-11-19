# Project 02 – Highly Available Three-Tier AWS Architecture

## Project Overview

This project demonstrates the design and implementation of a secure, scalable, and highly available three-tier architecture on Amazon Web Services (AWS), provisioned using Terraform.

The architecture separates the presentation, application, and database layers across two AWS Availability Zones.

It uses reusable Terraform modules and a Python Flask application connected to Amazon RDS for MySQL.

**Project Status:** Infrastructure configuration implemented and Terraform plan validated. AWS deployment and live testing are pending.

## Architecture

The architecture consists of three tiers:

1. **Presentation Tier:** Internet-facing Application Load Balancer (ALB).
2. **Application Tier:** Python Flask application hosted on Amazon EC2 instances in private subnets, managed by an Auto Scaling Group.
3. **Database Tier:** Amazon RDS for MySQL configured for Multi-AZ deployment.

The infrastructure spans two Availability Zones to improve resilience and availability.

See [AWS Architecture Documentation](architecture/aws-architecture.md) for the network design and architecture diagram.

## Architecture Highlights

- Custom VPC with public and private subnets.
- Two Availability Zones.
- Internet Gateway and two NAT Gateways.
- Internet-facing Application Load Balancer.
- EC2 Auto Scaling Group across private subnets.
- Amazon RDS MySQL Multi-AZ deployment.
- Security Groups controlling communication between tiers.
- IAM instance role for application access to AWS services.
- AWS Secrets Manager for database credentials.
- Amazon CloudWatch dashboard and alarms.

## AWS Services

| AWS Service | Purpose |
|---|---|
| Amazon VPC | Isolated cloud network |
| Public and Private Subnets | Network segmentation |
| Internet Gateway | Internet connectivity for public resources |
| NAT Gateway | Outbound connectivity for private resources |
| Application Load Balancer | Distributes incoming application traffic |
| Amazon EC2 | Hosts the Flask application |
| Auto Scaling Group | Maintains and scales application capacity |
| Amazon RDS MySQL | Managed relational database |
| AWS IAM | Identity and access management |
| AWS Secrets Manager | Secure database credential storage |
| Amazon CloudWatch | Monitoring, dashboard and alarms |

## Application

The application is developed using Python Flask and connects to Amazon RDS MySQL.

Application functionality includes:

- Database connectivity through AWS Secrets Manager.
- Website visit counter stored in MySQL.
- Application health endpoint at `/health`.
- Gunicorn application server.
- Apache HTTP Server acting as a reverse proxy.

The application is deployed automatically through EC2 user data.

## Terraform Module Structure

The infrastructure is organized into reusable Terraform modules:

```text
terraform/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── modules/
    ├── network/
    ├── compute/
    ├── database/
    ├── security/
    └── monitoring/
```

### Module Responsibilities

- **Network:** VPC, subnets, Internet Gateway, NAT Gateways and routing.
- **Compute:** Application Load Balancer, EC2 Launch Template, Auto Scaling Group and IAM.
- **Database:** RDS MySQL instance and DB subnet group.
- **Security:** Security Groups for the ALB, application and database tiers.
- **Monitoring:** CloudWatch dashboard and infrastructure alarms.

## Security Features

- Application EC2 instances deployed in private subnets.
- Database deployed in private database subnets.
- Database access restricted to the application security group.
- Application traffic accepted only from the ALB security group.
- IAM permissions scoped to the required database secret.
- Database credentials retrieved from AWS Secrets Manager.
- Encrypted RDS storage.
- Encrypted EC2 root EBS volumes.
- IMDSv2 required for EC2 instances.

## High Availability

- Two Availability Zones.
- Application Load Balancer spanning both public subnets.
- EC2 Auto Scaling Group across private application subnets.
- Two NAT Gateways, one per Availability Zone.
- Amazon RDS Multi-AZ deployment for database failover.

**Note:** RDS Multi-AZ provides standby failover capability. It is not a read replica for read scaling.

## Monitoring

The Terraform configuration includes:

- CloudWatch dashboard.
- EC2 CPU utilization alarm.
- ALB unhealthy host alarm.
- RDS CPU utilization alarm.

## Technology Stack

- Amazon Web Services (AWS)
- Terraform
- Python
- Flask
- Gunicorn
- Apache HTTP Server
- MySQL
- Linux
- Git and GitHub

## Deployment Prerequisites

- AWS account.
- AWS CLI v2.
- Terraform CLI.
- Git.
- VS Code (recommended).
- An AWS IAM identity with the permissions required to provision the project.

## Deployment Status

The Terraform configuration has been formatted, validated and successfully planned.

The latest plan proposed:

- 45 resources to add.
- 0 resources to change.
- 0 resources to destroy.

No AWS infrastructure has been deployed yet.

Deployment instructions and live testing results will be added after the AWS environment is provisioned.

## Cost Considerations

This architecture includes chargeable AWS resources, including:

- NAT Gateways.
- Application Load Balancer.
- EC2 instances.
- Multi-AZ RDS.
- Secrets Manager.
- CloudWatch.

Review AWS pricing before deployment. Deploy for controlled testing and destroy resources when no longer required, after protecting important data and Terraform state.

## Future Improvements

- HTTPS using AWS Certificate Manager.
- GitHub Actions for Terraform validation.
- Remote Terraform state storage with encryption and locking.
- SNS notifications for CloudWatch alarms.
- Additional security and infrastructure testing.
- Application-specific least-privilege database credentials.

## Author

**Kashif Riaz**

- GitHub: [kashifaws786](https://github.com/kashifaws786)
- LinkedIn: [Kashif Riaz](https://www.linkedin.com/in/k-r-b-4a46a43)
