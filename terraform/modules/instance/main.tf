resource "yandex_compute_instance" "master" {
  count = var.master
  name        = "master-${count.index}"
  platform_id = "standard-v1"
  hostname    = "master-${count.index}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.Instance_family_image
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "cloud:${file("~/.ssh/cloud.pub")}"
    user_data = <<-EOF
    #cloud-config
    users:
      - name: cloud
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
    EOF
  }
}

resource "yandex_compute_instance" "app" {
  count = var.worker
  name        = "app-${count.index}"
  platform_id = "standard-v1"
  hostname    = "app-${count.index}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.Instance_family_image
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "cloud:${file("~/.ssh/cloud.pub")}"
    user_data = <<-EOF
    #cloud-config
    users:
      - name: cloud
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
    EOF
  }
}

resource "yandex_compute_instance" "srv" {
  count = var.srv
  name        = "srv-${count.index}"
  platform_id = "standard-v1"
  hostname    = "srv-${count.index}"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.Instance_family_image
      size     = 20
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "cloud:${file("~/.ssh/cloud.pub")}"
    user_data = <<-EOF
    #cloud-config
    users:
      - name: cloud
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
    EOF
  }
}
