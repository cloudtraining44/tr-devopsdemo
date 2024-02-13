variable "numbers" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}

output "even_numbers" {
  value = [for num in var.numbers : num * 2]  # Using list comprehension
}

output "first_two_numbers" {
  value = var.numbers[0]                      # Accessing the first element
}

output "all_numbers" {
  value = var.numbers[*]                      # Splat expression to get all elements
}

###############################################################
###############################################################

variable "users" {
  type = map(object({
    name  = string
    email = string
  }))
  default = {
    user1 = { name = "Alice", email = "alice@example.com" }
    user2 = { name = "Bob", email = "bob@example.com" }
  }
}

output "user_names" {
  value = { for key, user in var.users : key => user.name }  # Using map comprehension
}

output "first_user" {
  value = var.users["user1"]                                  # Accessing a specific element
}

output "all_users" {
  value = var.users[*]                                         # Splat expression to get all elements
}

########################################################################
variable "instances" {
  type = map(object({
    create = bool
    ami    = string
    type   = string
  }))
  default = {
    example1 = { create = true, ami = "ami-0c55b159cbfafe1f0", type = "t2.micro" }
    example2 = { create = false, ami = "ami-xxxxxxxxxxxxxxxxx", type = "t2.small" }
  }
}
output "instances" {
    value =  { for k, v in var.instances : k => v if v.create==false}
}