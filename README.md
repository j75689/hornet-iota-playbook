
```bash
cd hornet
terraform init
terraform apply -var-file ../example/hornet.tfvars
terraform destroy

cd monitor
terraform init
terraform apply -var-file ../example/monitor.tfvars
terraform destroy
```