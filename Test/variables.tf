variable "bastion_hosts" {
  type = map(
    object({
    resource_group_name = string
    virtual_network_rg = string
    virtual_network_name = string
    subnet_name = string
    availability_zone = number 
    type = map(
      object({
      disk_size = number
      caching = string
      create_option = string
      storage_account_name = string
    })
    )
    type = map(
      object({
      publisher = string
      offer = string
      sku = string
      version = string
    })
    )
    type = map(
      object({
      name = string
      publisher = string
      product = string
    })
    )
  })
  )
}
