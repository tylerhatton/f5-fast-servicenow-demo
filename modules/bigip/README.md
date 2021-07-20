<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| random | n/a |
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| default\_tags | n/a | `map(any)` | `{}` |
| name\_prefix | Prefix applied to name of resources | `string` | `""` |
| vpc\_id | n/a | `string` | n/a |
| subnet\_id | n/a | `string` | n/a |
| key\_pair | n/a | `string` | `null` |
| instance\_type | n/a | `string` | `"t2.large"` |

## Outputs

| Name | Description |
|------|-------------|
| bigip\_public\_ip | n/a |
| bigip\_private\_ip | n/a |
| admin\_username | n/a |
| admin\_password | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->