**Lab overview**
In this lab, you create a basic Amazon Virtual Private Cloud (Amazon VPC) without using the VPC Wizard. Amazon VPC lets you provision a logically isolated section of the Amazon Web Services (AWS) cloud where you can launch AWS resources in a virtual network that you define. You have complete control over your virtual networking environment, including selection of your own IP address range, creation of subnets, and configuration of route tables and network gateways. You can use both IPv4 and IPv6 in your VPC for secure and easy access to resources and applications.

The VPC that you build includes a web server and an Amazon RDS database. Once you have created both, you connect your address book application running on your web server to your Amazon RDS for MySQL instance. Once you successfully configure your address book application with your RDS instance, you are be able to add and remove contacts from the address book.

**TOPICS COVERED**
In this lab below components are covered using the Terraform:

Create an Amazon Virtual Private Cloud (VPC)

Create a public and private subnets
Create an Internet gateway
Create a Route Table and add a route to the Internet
Create a security group for your web server to only allow HTTP traffic to your web server
Create a security group for your MySQL RDS instance to only allow MySQL traffic from your public subnet
Deploy a web server and a MySQL RDS instance
Configure your application to connect to your MySQL RDS instance

