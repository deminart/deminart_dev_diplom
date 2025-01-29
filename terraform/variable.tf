# Указать свое значение folder_id
variable "folder_id" {
  description = "Yandex Folder id"
  type = string
  default = "b1g1ttnd6oa97n5ng69p"  # Ваш folder_id
}

# Указать свое значение cloud_id
variable "cloud_id" {
  description = "Yandex Cloud id"
  type = string
  default = "b1g10kn7pv6llj5u4am4"  # Ваш cloud_id
}

# Указать зону где нужно создать инфраструктуру
variable "zone" {
    description = "Zone infra"
    type = string
    default = "ru-central1-a"  # Ваш compute-default-zone
}
