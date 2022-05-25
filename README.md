# My-Second-Terrafom-Project
In this project, I've created a secure networking for an ongoing project using the AWS platform.
It consist of 5 subnets spanning across two AZs.
Two route tables have been created and associated with the public and private subnets.
An internet gateway has been created and associated with the public route table.
A Nat gateway has been placed in one of the public subnets and has been associated with the private route table to ensuse updating, patching, etc of the contents in the private subnets.

The project was executed using terraform.
The structure consists of a folder (My-Second-Terraform-Project), within which are three files namely; provider.tf, main.tf, and variable.tf.
the provider.tf defines the cloud provider which is AWS.
The main.tf contains the codes used in bulding the VPC (the networking).
The variable.tf contains a decleared input variables which give colleagues and other users the option to customise aspects of this module without altering the source code.
For instace, in this project, the region name and the AZ names were edited within the variable.tf file to create a second VPC in a diffeerent region with the same parameters. 
