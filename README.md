# terraform-aws-kms-alias

Terraform module for a KMS alias — a human-readable name for a
[`terraform-aws-kms-key`](https://github.com/kn47ytv9mv/terraform-aws-kms-key),
since every reference to a bare key ID or ARN elsewhere in this family
is otherwise opaque.

## Cost

A KMS alias has no charge of its own — it is a free pointer to the key
it targets. See
[`terraform-aws-kms-key`](https://github.com/kn47ytv9mv/terraform-aws-kms-key)'s
own Cost section for where the real charges originate.

## Design

`name` takes just the alias's own short name, not the full
`'alias/...'` form AWS requires on every KMS alias — this module adds
that prefix automatically, since it is unconditional AWS boilerplate
with no real caller choice behind it, not a meaningful setting. Passing
a name that already starts with `'alias/'` is rejected directly, to
catch the `'alias/alias/my-key'` mistake before AWS does.

## Usage

```hcl
module "app_key_alias" {
  source = "kn47ytv9mv/kms-alias/aws"

  name           = "my-app-key"
  target_key_id  = module.app_key.id
}
```

Or directly from this repository:

```hcl
module "app_key_alias" {
  source = "github.com/kn47ytv9mv/terraform-aws-kms-alias"

  name           = "my-app-key"
  target_key_id  = module.app_key.id
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.3 |
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| name | The alias's own name, without the 'alias/' prefix AWS requires on every KMS alias — this module adds it automatically (e.g. 'my-app-key' becomes 'alias/my-app-key'). If null, a unique name is generated. | `null` | no |
| target_key_id | The ID or ARN of the KMS key this alias points to — from terraform-aws-kms-key's id or arn output. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The full name of the alias, including the 'alias/' prefix. |
| arn | The ARN of the alias. |
| name | The full name of the alias, including the 'alias/' prefix this module adds. |

## License

MIT — see [LICENSE.md](LICENSE.md).
