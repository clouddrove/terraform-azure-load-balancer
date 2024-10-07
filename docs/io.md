## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocation\_method | Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | `""` | no |
| application | Application (e.g. `cd` or `clouddrove`). | `string` | `""` | no |
| backendpoolname | (Required) Specifies the name of the Backend Address Pool. Changing this forces a new resource to be created. | `string` | `"test-backendpool"` | no |
| create | Used when creating the Resource Group. | `string` | `"60m"` | no |
| ddos\_protection\_mode | (Optional) The DDoS protection mode of the public IP. Possible values are `Disabled`, `Enabled`, and `VirtualNetworkInherited`. Defaults to `VirtualNetworkInherited`. | `string` | `"VirtualNetworkInherited"` | no |
| delete | Used when deleting the Resource Group. | `string` | `"60m"` | no |
| domain\_name\_label | Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. | `string` | `null` | no |
| edge\_zone | (Optional) Specifies the Edge Zone within the Azure Region where this Public IP and Load Balancer should exist. Changing this forces new resources to be created. | `string` | `null` | no |
| enabled | Flag to control the module creation. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| frontend\_name | (Required) Specifies the name of the frontend ip configuration. | `string` | `"myip"` | no |
| frontend\_private\_ip\_address | (Optional) Private ip address to assign to frontend. Use it with type = private | `string` | `""` | no |
| frontend\_private\_ip\_address\_allocation | (Optional) Frontend ip allocation type (Static or Dynamic) | `string` | `"Dynamic"` | no |
| frontend\_private\_ip\_address\_version | (Optional) The version of IP that the Private IP Address is. Possible values are `IPv4` or `IPv6`. | `string` | `null` | no |
| frontend\_subnet\_id | (Optional) Frontend subnet id to use when in private mode | `string` | `null` | no |
| idle\_timeout\_in\_minutes | Specifies the timeout for the TCP idle connection. The value can be set between 4 and 60 minutes. | `number` | `10` | no |
| ip\_configuration\_name\_association | (Required) Ip Configuration name for Network Interaface Association with Load Balancer. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| ip\_count | Number of Public IP Addresses to create. | `number` | `0` | no |
| ip\_version | The IP Version to use, IPv6 or IPv4. | `string` | `""` | no |
| is\_enable\_backend\_pool | Backend Pool Configuration for the Load Balancer. | `bool` | `false` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| lb\_port | Protocols to be used for lb rules. Format as [frontend\_port, protocol, backend\_port] | `map(any)` | `{}` | no |
| lb\_probe | (Optional) Protocols to be used for lb health probes. Format as [protocol, port, request\_path] | `map(any)` | `{}` | no |
| lb\_probe\_interval | Interval in seconds the load balancer health probe rule does a check | `number` | `5` | no |
| lb\_probe\_unhealthy\_threshold | Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy. | `number` | `2` | no |
| lb\_sku | (Optional) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. | `string` | `"Basic"` | no |
| location | Location where resource should be created. | `string` | `""` | no |
| managedby | ManagedBy, eg 'CloudDrove' or 'AnmolNagpal'. | `string` | `"anmol@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| nat\_protocol | (Required) The protocol of Load Balancer's NAT rule. | `string` | `"Tcp"` | no |
| net\_count | Number of network Addresses to create. | `number` | `0` | no |
| network\_interaface\_id\_association | (Required) Network Interaface id for Network Interface Association with Load Balancer. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| public\_ip\_enabled | Whether public IP is enabled. | `bool` | `false` | no |
| public\_ip\_prefix\_id | If specified then public IP address allocated will be provided from the public IP prefix resource. | `string` | `null` | no |
| read | Used when retrieving the Resource Group. | `string` | `"5m"` | no |
| remote\_port | Protocols to be used for remote vm access. [protocol, backend\_port].  Frontend port will be automatically generated starting at 50000 and in the output. | `map(any)` | `{}` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. | `string` | `""` | no |
| reverse\_fqdn | A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN. | `string` | `""` | no |
| sku | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. | `string` | `"Basic"` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| update | Used when updating the Resource Group. | `string` | `"60m"` | no |
| zones | A collection containing the availability zone to allocate the Public IP in. | `list(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| azurerm\_lb\_backend\_address\_pool\_id | the id for the azurerm\_lb\_backend\_address\_pool resource |
| azurerm\_lb\_frontend\_ip\_configuration | the frontend\_ip\_configuration for the azurerm\_lb resource |
| azurerm\_lb\_id | the id for the azurerm\_lb resource |
| azurerm\_lb\_nat\_rule\_ids | the ids for the azurerm\_lb\_nat\_rule resources |
| azurerm\_lb\_probe\_ids | the ids for the azurerm\_lb\_probe resources |
| azurerm\_public\_ip\_address | the ip address for the azurerm\_lb\_public\_ip resource |
| azurerm\_public\_ip\_id | the id for the azurerm\_lb\_public\_ip resource |
