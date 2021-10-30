//Project Id
variable "project_id" {
description ="project id"
}
//Region
variable "region" {
default ="us-central1"
}
//Zone
variable "zone" {
default ="us-central1-a"
}
 
// Machine_type
variable "machine_type" {
type        = string
description = "GCP machine type"
default     = "e2-medium"
 
}
 
//Subnet
variable "sub" {
default = "sub-1"
}
 
//CIDR range
variable "ip_cidr" {
default = "10.0.0.0/8"
}
//FIREWALL
variable "firewall"{
   default = "firewall-1"
}
//ROM
variable "rom" {
description = "OS Image"
default     = "centos-cloud/centos-8"
}
//USER
variable "user" {
default ="sathish_indin"
}
//PRIVATE KEY
variable "ssh_private_key" {
default ="~/.ssh/id_rsa"
}
//PUBLIC KEY 
variable "ssh_public_key" {
default ="~/.ssh/id_rsa.pub"
}
 
 
 


