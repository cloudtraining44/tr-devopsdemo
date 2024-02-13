variable "access_key" {
  default = "AKIA44EQJ67T5BA3LCPO"
  type = string
}

variable "secret_key" {
  default = "3VzxBfRlFn5WNdZ5h8iZ+B7mZFCGFZUZfQRLlIYY"
  type = string
}

variable "env" {
    default = ""
    type = string
}

variable "name" {
    type =  string
    default = "tr-devops"
}

variable "instance_attr" {
    type = map(object({
      ami = string
      instance_type = string
    }))
    
    default = {
      "ec2-1" = {
        ami = "ami-0759f51a90924c166"
        instance_type  = "t2_micro"        
      }
      "ec2-2" = {
        ami  = "ami-0759f51a90924c166"
        instance_type = "t2_micro"
      }
    }
  }