<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| default\_tags | n/a | `map(any)` | `{}` |
| name\_prefix | Prefix applied to name of resources | `string` | `""` |
| vpc\_id | n/a | `string` | n/a |
| subnet\_id | n/a | `string` | n/a |
| key\_pair | n/a | `string` | `null` |
| instance\_count | n/a | `number` | `2` |

## Outputs

| Name | Description |
|------|-------------|
| private\_ips | n/a |
| names | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->