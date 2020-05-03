// variables

variable "cidr-block" {
    default = "192.168.1.0/24"
}

variable "vpc-name" {
    default = "ingress"
}

variable "cidr-block-subnet" {
    default = "192.168.1.0/26"
}

variable "subnet-name" {
    default = "ingress-Subnet"
}

variable "igw-name" {
    default = "ingress-gtw"
}

variable "cidr-block-rt" {
    default = "0.0.0.0/0"
}

variable "rt-name" {
    default = "rt-ingress"
}

variable "sg-name" {
    default = "sgingress"
}

variable "sg-desc" {
    default = "Allow HTTP & SSH inbound traffic"
}

variable "key-name" {
    default = "terraform-key"
}

variable "pub-key" {
    default = "#add your public key#"
}

variable "ami-id" {
    default = "ami-076431be05aaf8080"
}

variable "intance-type" {
    default = "t2.micro"
}

variable "instance-name" {
    default = "apache"
}