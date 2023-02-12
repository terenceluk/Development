variable "bastion_hosts" {
  type = map(object({
    top_variable1 = string
    top_variable2 = string
    top_variable3 = number 
      additional_data_disks = map(object({
        disk_size = number
        caching = string
  })
  )
  }))
}