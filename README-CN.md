阿里云DNS管理Terraform模块

# terraform-alicloud-alidns

[English](https://github.com/alibabacloud-automation/terraform-alicloud-alidns/blob/main/README.md) | 简体中文

用于创建和管理阿里云DNS资源的Terraform模块，包括域名、DNS实例、GTM实例、DNS记录和高级DNS功能。该模块为[阿里云DNS服务](https://www.alibabacloud.com/product/dns)提供全面的DNS管理功能，使用户能够高效管理域名、配置DNS解析、设置全局流量管理，以及实现高级DNS路由策略。

## 使用方法

此模块允许您在阿里云上创建和管理各种DNS资源。您可以使用它来设置基本的域名管理、配置DNS记录，或实现高级功能，如带有健康检查和故障转移能力的全局流量管理(GTM)。

```terraform
module "alidns" {
  source = "alibabacloud-automation/alidns/alicloud"

  # 域名分组和域名配置
  create_domain_group = true
  domain_group_config = {
    domain_group_name = "my-domain-group"
  }

  create_domain = true
  domain_config = {
    domain_name = "example.com"
    remark      = "由Terraform管理"
  }

  # DNS记录配置
  dns_records_config = {
    www_record = {
      domain_name = "example.com"
      rr          = "www"
      type        = "A"
      value       = "192.168.1.1"
      ttl         = 600
    }
    mail_record = {
      domain_name = "example.com"
      rr          = "mail"
      type        = "CNAME"
      value       = "mail.example.com"
      ttl         = 600
    }
  }

  # 通用标签
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-alidns/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)