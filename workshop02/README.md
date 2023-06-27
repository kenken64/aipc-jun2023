## Workshop 2 (Terraform + Ansible)

- Provision code server using terraform 
- Configure and setup the rest of the stuff using Ansible

https://www.digitalocean.com/community/tutorials/how-to-set-up-the-code-server-cloud-ide-platform-on-ubuntu-20-04

```
export DO_PAT = xxxxxxxxx
```

```
terraform init
```

```
terraform plan -var "do_token=${DO_PAT}" -var "ssh_private_key=/root/.ssh/id_rsa" -var "codeserver_password=password123456"
```

```
terraform apply -var "do_token=${DO_PAT}" -var "ssh_private_key=/root/.ssh/id_rsa" -var "codeserver_password=password123456"
```