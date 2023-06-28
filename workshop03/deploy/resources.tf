data "digitalocean_ssh_key" "www-1" {
    name = var.do_ssh_key
}

#data "digitalocean_image" "codeserver" {
#    name = "codeserver"
#}


data "digitalocean_droplet_snapshot" "codeserver-snapshot" {
  name = "codeserver"
  most_recent = true
}

resource "digitalocean_droplet" "codeserver" {
    name = "codeserver"
    image  = data.digitalocean_droplet_snapshot.codeserver-snapshot.id
    region = var.do_region
    size = var.do_size

    ssh_keys = [ data.digitalocean_ssh_key.www-1.id ] 

    connection {	
	type = "ssh"
	user = "root"
	private_key = file(var.ssh_private_key)
	host = self.ipv4_address
    }

    provisioner remote-exec {
	inline = [
		"sed -i 's/__DOMAIN_NAME__/${self.ipv4_address}-${var.cs_domain}/g' /etc/nginx/sites-available/code-server.conf",
        	"sed -i 's/__CODESERVER_PASSWORD__/${var.cs_password}/g' /lib/systemd/system/code-server.service",
		"systemctl daemon-reload",
		"systemctl restart code-server",
		"systemctl restart nginx",
	]
    }

}

output codeserver_ip {
	value = digitalocean_droplet.codeserver.ipv4_address
}

