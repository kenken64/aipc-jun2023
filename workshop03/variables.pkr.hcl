variable do_token {
    type = string
    sensitive = true
}

variable do_region {
    type = string
    default = "sgp1"
}

variable do_image {
    type = string
    default = "ubuntu-20-04-x64"
}

variable do_size {
    type = string
    default = "s-1vcpu-1gb"
}
