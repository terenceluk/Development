galary = {
  galary1 = {
    resource_group_name = "ctc-nonprod-tfmodules-cc-rg"
    environment         = "nonprod"
    location            = "Canada Central"
    images = {
      images1 = {
        name           = "rhel-core7"
        os_type        = "Linux"
        publisher_name = "ctc"
        offer          = "rhel"
        sku            = "7"
      }
      images2 = {
        name           = "win-core"
        os_type        = "Windows"
        publisher_name = "ctc"
        offer          = "windows"
        sku            = "2016"
      }
    }
  }
}