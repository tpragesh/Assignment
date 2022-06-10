The Assignment is completed in terraform, below is the architecture diagram and the steps to run.

![alt text](./Arch-Diagram.png)

# Steps to run:
===================

Once you have terraform installed, clone the files and then run below Commands.

[1] Initialize Terraform:-
>> terraform init

[2] Validate Terraform configuration files:-
>> terraform validate

[3] Format Terraform configuration files:-
>> terraform fmt

[4] Review the terraform plan:-
>> terraform plan

[5] Create Resources:-
>> terraform apply -var="aws_region=REGION"

Example: terraform apply -var="aws_region=us-east-1"

