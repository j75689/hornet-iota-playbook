# Hornet Deployment
This script helps you start any number of Hornet Mainnet nodes.

## Usage

- Initialize the terraform library by `terraform init`.
- Create the variable file you want to configure.
- Start deploying by `terraform apply -var-file ${variables_file}`
- Destroy all resources that have already been deployed by `terraform destroy -var-file ${variables_file}`.

## Example
```bash
terraform init
terraform apply -var-file ../example/hornet.tfvars
terraform destroy -var-file ../example/hornet.tfvars
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
| cluster_network_cidr | list(string) | Private port allowed IP mask | `"172.31.0.0/16"` |
|---|---|---|---|
| iota_hornet_image | string | Docker version of Hornet | `gohornet/hornet:latest` |
| dashboard_username | string | Username of Hornet dashboard | `null` |
| dashboard_password_hash | string | Password Hash of Hornet dashboard | `null` |
| dashboard_password_salt | string | Password Salt of Hornet dashboard | `null` |
|---|---|---|---|
| enable_logging | bool | Whether to enable loggin module | `false` |
| awslogs_region | string | AWS cloudwatch log region | `ap-northeast-1` |
| awslogs_create_group | bool | Whether to create logs group on AWS cloudwatch automatically | `true` |
|---|---|---|---|
| enable_proxy | bool | Whether to enable proxy | `false` |
| traefik_image | string | Traefik version | `traefik:latest` |
| letsencrypt_acme_email | string | ACME mail address of letsencrypt | `""` |
| letsencrypt_domain | list(string) | Domains of the Hornet api server | `[]` |

## Hornet Configuration
If you want to modify the configuration file of the Hornet node, you can modify `scripts/config.json`, `scripts/profiling.json`, `scripts/peering.json`

## SSL
The deploy script can enable proxy with SSL certificate, set `enbale_proxy`, `letsencrypt_acme_email`, `letsencrypt_domain` into variable file, then the API endpoint of Hornet will automatically obtain the Let's Encrypt certificate and automatically extend it before the certificate expires.
This function is done through the `Traefik` configuration.
If you want to configure your own SSL credentials, you can modify the `Traefik` related configuration in `scripts/docker-compose.yaml`.

Check the deatil by [Traefik TLS](https://traefik.io/blog/traefik-2-tls-101-23b4fbee81f1/)

## Logging
The deploy script can enable the log parser to collect Hornet logs and send them to `AWS CloudWatch`.
Set `enable_logging`, `awslogs_region` into variable file, then you can enable this function.

It's also easy to configure different log systems, modify the logging option in `scripts/docker-compose.yaml`.

Check the detail by [Docker Logging](https://docs.docker.com/config/containers/logging/configure/)
