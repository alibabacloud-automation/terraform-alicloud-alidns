# Complete Example

This example demonstrates the complete usage of the terraform-alicloud-alidns module with various DNS management features.

## Features Demonstrated

- Domain group creation and management
- Domain registration and configuration
- DNS instance setup (optional)
- DNS records management (A, CNAME records)
- GTM (Global Traffic Manager) instance setup (optional)
- Address pools configuration for GTM
- Custom lines configuration (optional)
- Resource tagging

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create real resources in your Alibaba Cloud account. Make sure to destroy them after testing:

```bash
$ terraform destroy
```

## Configuration

### Basic Configuration

The example creates a basic DNS setup with:
- A domain group named "terraform-example-group"
- A domain "example-terraform.com" (you should change this to your own domain)
- Basic DNS records (www and mail)

### Advanced Features (Optional)

To enable advanced features, set these variables to `true`:

- `create_dns_instance = true` - Creates a paid DNS instance
- `create_domain_attachment = true` - Attaches the domain to the DNS instance
- `create_gtm_instance = true` - Creates a GTM instance with address pools
- `enable_custom_lines = true` - Creates custom DNS resolution lines

### Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where to deploy the resources | `string` | `"cn-hangzhou"` | no |
| domain_name | The domain name to manage | `string` | `"example-terraform.com"` | no |
| domain_group_name | The name of the domain group | `string` | `"terraform-example-group"` | no |
| create_dns_instance | Whether to create a DNS instance | `bool` | `false` | no |
| create_gtm_instance | Whether to create a GTM instance | `bool` | `false` | no |
| enable_custom_lines | Whether to enable custom lines | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| domain_group_id | The ID of the created domain group |
| domain_id | The ID of the created domain |
| domain_name | The name of the created domain |
| dns_servers | A list of the DNS server names |
| dns_instance_id | The ID of the created DNS instance |
| gtm_instance_id | The ID of the created GTM instance |
| address_pool_ids | A map of address pool names to their IDs |
| dns_record_ids | A map of DNS record names to their IDs |
| custom_line_ids | A map of custom line names to their IDs |

## Important Notes

1. **Domain Name**: You must change the `domain_name` variable to a domain you own and control.

2. **Paid Resources**: DNS instances and GTM instances are paid resources. Set the corresponding creation flags to `false` if you don't want to incur charges.

3. **Prerequisites**: 
   - You need an Alibaba Cloud account with appropriate permissions
   - The domain must be registered and available for DNS management

4. **Resource Dependencies**: Some resources depend on others:
   - Domain attachment requires a DNS instance
   - Address pools require a GTM instance
   - Access strategies require both GTM instance and address pools

## Cost Considerations

- Basic domain and DNS records management is typically free
- DNS instances incur monthly charges based on the selected version
- GTM instances are premium features with additional costs
- Review Alibaba Cloud DNS pricing before enabling paid features