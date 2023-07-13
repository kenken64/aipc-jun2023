## Workshop Day 0

```
ssh-keygen
```

Open a terminal and run the following command:

```
ssh-keygen
```

Copy
You will be prompted to save and name the key.

```
Generating public/private rsa key pair. Enter file in which to save the key (/Users/USER/.ssh/id_rsa): 
```

Next you will be asked to create and confirm a passphrase for the key (highly recommended):

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again: 
```

This will generate two files, by default called id_rsa and id_rsa.pub. Next, add this public key.

Add the public key
Copy and paste the contents of the .pub file, typically id_rsa.pub, into the SSH key content field on the left.

```
cat ~/.ssh/id_rsa.pub
```
Copy
For more detailed guidance, see How to Add SSH Keys to Droplets


1. Install terraform

https://developer.hashicorp.com/terraform/downloads

```
ssh root@143.198.204.164
```

```
ssh-keygen
```

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

```
sudo apt update && sudo apt install terraform
```

### Install docker engine 

https://docs.docker.com/engine/install/ubuntu/


```
terraform -version
```

```
Terraform v1.5.1
on linux_amd64
```

```
export DO_PAT=xxxxxx
```

```
export TF_LOG=1
```

```
terraform init
```

```
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "aipc" {
  name = "aipc"
}
```

```
resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-20-04-x64"
  name = "www-1"
  region = "sgp1"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.aipc.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}
```

```
terraform plan -auto-approve \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=$HOME/.ssh/id_rsa"
```


```
terraform apply -auto-approve \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=$HOME/.ssh/id_rsa"
```

```
terraform show terraform.tfstate
```


```
sed 's/www-1/www-2/g' www-1.tf > www-2.tf
```

## change the private to the www-1


```
terraform destroy \
  -var "do_token=${DO_PAT}" \
  -var "pvt_key=$HOME/.ssh/id_rsa"
```


## Workshop Day 1


To download and install the Docker Machine binary, type:

```
wget https://github.com/docker/machine/releases/download/v0.14.0/docker-machine-$(uname -s)-$(uname -m)
```
The name of the file should be docker-machine-Linux-x86_64. Rename it to docker-machine to make it easier to work with:
```
mv docker-machine-Linux-x86_64 docker-machine
```
Make it executable:
```
chmod +x docker-machine
```
Move or copy it to the usr/local/bin directory so that it will be available as a system command.
```
sudo mv docker-machine /usr/local/bin
```
Check the version, which will indicate that it’s properly installed:
```
docker-machine version
```


```
docker-machine create \
        -d digitalocean \
        --digitalocean-access-token  <do_pat_key> \
        --digitalocean-image ubuntu-18-04-x64  \
        --digitalocean-region sgp1 \
        --digitalocean-backups=false \
        --engine-install-url "https://releases.rancher.com/install-docker/19.03.9.sh" \
        docker-nginx
```

https://docs.digitalocean.com/reference/terraform/getting-started/

```
terraform plan -auto-approve -var "do_token=${DO_PAT}" -var "ssh_private_key=/root/workshop01/id_rsa" -var "docker_host=167.172.83.19" -var "docker_cert_path=/root/.docker/machine/machines/docker-nginx"
```

```
terraform apply -auto-approve -var "do_token=${DO_PAT}" -var "ssh_private_key=/root/workshop01/id_rsa" -var "docker_host=167.172.83.19" -var "docker_cert_path=/root/.docker/machine/machines/docker-nginx"
```
