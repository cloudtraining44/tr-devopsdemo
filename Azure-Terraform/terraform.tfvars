resource_group_name = "941-bfc70ac6-create-an-aks-cluster-and-deploy-appl"
subnet_configuration = {
  ingress = "10.64.4.0/24"
  nodes   = "10.64.0.0/22"
}
vnet_address_space = ["10.64.0.0/16"]