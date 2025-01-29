terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAAAK7zPmAATuwQAAAAEQMgNsAACT8fSgO95Fd7A2pNe1EVqO9vW9aw"
  cloud_id  = "b1g10kn7pv6llj5u4am4"
  folder_id = "b1g1ttnd6oa97n5ng69p"
  zone      = "ru-central1-a"
}

variable "ssh_key_path" {
  description = "Path to SSH public key"
  default     = "~/.ssh/cloud.pub"
}

// Создание сети
resource "yandex_vpc_network" "default" {
  name = "default"
}

// Создание подсети
resource "yandex_vpc_subnet" "default" {
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.5.0.0/24"]
  zone           = "ru-central1-a"
}

// Функция для создания инстансов
resource "yandex_compute_instance" "master" {
  name        = "master"
  platform_id = "standard-v1"
  hostname    = "master"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      users:
        - name: cloud
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          ssh-authorized-keys:
            - ${file(var.ssh_key_path)}
    EOT
  }
}

resource "yandex_compute_instance" "app" {
  name        = "app"
  platform_id = "standard-v1"
  hostname    = "app"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      users:
        - name: cloud
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          ssh-authorized-keys:
            - ${file(var.ssh_key_path)}
    EOT
  }
}

resource "yandex_compute_instance" "srv" {
  name        = "srv"
  platform_id = "standard-v1"
  hostname    = "srv"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8v0s6adqu3ui3rsuap"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = <<-EOT
      #cloud-config
      users:
        - name: cloud
          sudo: ALL=(ALL) NOPASSWD:ALL
          shell: /bin/bash
          ssh-authorized-keys:
            - ${file(var.ssh_key_path)}
    EOT
  }
}
