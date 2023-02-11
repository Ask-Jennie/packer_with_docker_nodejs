packer {
  required_version = ">= 1.8"
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
  }
}

variable "base_image" {
  type    = string
  default = "dockerexamplecontainer:latest"
}

variable "docker_repository" {
  type    = string
  default = ""
}

variable "docker_tags" {
  type    = list(string)
  default = []
}

variable "docker_save" {
  type    = bool
  default = false
}

variable "docker_save_path" {
  type    = string
  default = ""
}

source "docker" "static" {
  image  = var.base_image
  pull   = false
  commit = true
  changes = [
    "ENTRYPOINT [\"npm\"]",
    "CMD [\"start\"]"
  ]
}

build {
  name = "static"
  sources = [
    "source.docker.static"
  ]

  post-processors {
    post-processor "docker-tag" {
      repository = var.docker_repository != "" ? var.docker_repository : basename(path.cwd)
      tags       = var.docker_tags
      only       = ["docker.static"]
    }

    post-processor "docker-save" {
      only = [var.docker_save ? "docker.static" : "null"]
      path = var.docker_save_path != "" ? var.docker_save_path : "${basename(path.cwd)}.docker-amd64.tar"
    }
  }
}