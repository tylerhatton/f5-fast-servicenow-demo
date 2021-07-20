# F5 FAST ServiceNow Demo

A demonstration of setting a ServiceNow service catalog form to point to F5 FAST.

## Instructions

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.15.1 |
| aws | >= 3.27.0 |
| random | >= 3.1.0 |
| servicenow | >= 0.9.4 |
| template | >= 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.27.0 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| name\_prefix | n/a | `string` | `"sndemo"` |
| owner | The name of the owner that will be tagged to the provisioned resources. | `string` | `null` |
| servicenow\_url | n/a | `string` | n/a |
| servicenow\_username | n/a | `string` | n/a |
| servicenow\_password | n/a | `string` | n/a |

## Outputs

| Name | Description |
|------|-------------|
| bigip\_public\_ip | n/a |
| bigip\_private\_ip | n/a |
| bigip\_username | n/a |
| bigip\_password | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->