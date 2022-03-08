
```bash
cd hornet
terraform init
terraform apply -var-file ../example/hornet.tfvars
terraform destroy -var-file ../example/hornet.tfvars

cd monitor
terraform init
terraform apply -var-file ../example/monitor.tfvars
terraform destroy -var-file ../example/monitor.tfvars
```

## Grafana

node dashboard
https://grafana.com/grafana/dashboards/1860