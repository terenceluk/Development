## Requirements


| Name      | Version   |
| --------- | --------- |
| terraform | >= 0.13   |
| azurerm   | >= 2.92.0 |

## Providers

| Name    | Version   |
| ------- | --------- |
| azurerm | >= 2.92.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| ---- | ------ | ------- |

## Resources

| Name                                                                                                            |
| --------------------------------------------------------------------------------------------------------------- |
| [azurerm_key_vault_secret](https://registry.terraform.io/providers/hashicorp/azurerm/2.96.0/docs/resources/key_vault_secret) |

## Inputs

| Name                  | Description                                                                                                           | Type          | Default | Required |
| --------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------- | ------- | :------: |
| brand                 | Default brand name.                                                                                                   | `string`      | `"ctc"` |    no    |
| costcenter            | Assigned cost center.                                                                                                 | `string`      | `null`  |    no    |
| environment           | Which enviroment: sandbox, nonprod or prod                                                                            | `string`      | `n/a`   |   yes    |
| location              | Specifies the supported Azure location.                                                                               | `string`      | `n/a`   |   yes    |
| projectcode           | Assigned project code.                                                                                                | `string`      | `null`  |    no    |
| key\_vault\_name | The name of the keyvault in which secrets has to be created                                                      | `string`      | `n/a`  |   yes    |
| key\_vault\_rg                  | The resource group name of the key vault | `string`      | `n/a`  |   yes    |
| secrets  | details of the secret like secret_name, secret_value, content_type.          | ------------- | ------- |   yes    |
| tags                  | Tags to apply to all resources created.                                                                               | `map(string)` | `{}`    |    no    |

## Outputs

| Name | Description              |
| ---- | ------------------------ |
| az_kv_secret_id   | The ID of the KV Secret. |
| az_kv_secret_value   | The Value of the KV Secret. |

## Timeouts

| Name     | Description                                              |
| -------- | -------------------------------------------------------- |
| timeouts | block allows you to specify timeouts for certain actions |

## Additional info

---
Please use the markdown output produced by
https://github.com/terraform-docs/terraform-docs