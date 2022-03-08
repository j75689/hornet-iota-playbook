# Monitoring Deployment

## Usage

- Initialize the terraform library by `terraform init`.
- Create the variable file you want to configure.
- Start deploying by `terraform apply -var-file ${variables_file}`
- Destroy all resources that have already been deployed by `terraform destroy -var-file ${variables_file}`.

## Example
```bash
terraform init
terraform apply -var-file ../example/monitor.tfvars
terraform destroy -var-file ../example/monitor.tfvars
```

## Configurable
| name | type | desc | default|
|---|---|---|---|
| ssh_key_name | string | ssh key name of ec2 |`null`|
| ssh_key_file | string | ssh key file of ec2 | `null` |
| ssh_username |  string | The login user when running the deployment script | `ec2-user` |
| project| string | The project name of Moniroring server | `iota-aws` |
| region | string | The region on AWS that you want to deploy | `ap-northeast-1` |
| instance_type | string | The instance type of ec2 | `c5.xlarge` |
| cluster_size | string | The number of Monitoring servers you want to deploy | `1` |
| ec2_ebs_volume_size | string | The disk size of EBS will mount | `10` |
| ebs_mount_point | string | The sector that EBS will mount | `/dev/sdf` |
| subnet_id | string | Specify subnet id | `null` |
| vpc_id | string | Specify vpc id | `null` |
| ssh_inbound_block | list(string) | SSH allowed IP mask | `["0.0.0.0/0"]` |
| inbound_network_cidr | list(string) | HTTP/HTTPS allowed IP mask | `["0.0.0.0/0"]` |
| cluster_network_cidr | list(string) | Private port allowed IP mask | `"172.31.0.0/16"` |
|---|---|---|---|
| hornet_exporter | list(string) | Hornet metrics to be extracted by Prometheus | `[]` |
| node_exporter | list(string) | Hornet node metrics to be extracted by Prometheus | `[]` |
| enable_proxy | bool | Whether to enable proxy | `false` |
| traefik_image | string | Traefik version | `traefik:latest` |
| letsencrypt_acme_email | string | ACME mail address of letsencrypt | `""` |
| letsencrypt_domain | string | Domain name of the Grafana server | `""` |
