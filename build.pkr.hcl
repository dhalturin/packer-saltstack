variable "source_path" { type = string }
variable "box_name" { type = string }
variable "box_version" { type = string }
variable "vagrant_account" { type = string }

source "vagrant" "cloud" {
  communicator = "ssh"
  source_path  = var.source_path
  provider     = "virtualbox"
  add_force    = true
  box_name     = "${var.box_name}-salt"
  box_version  = var.box_version
  output_dir   = "output/${var.box_name}-${var.box_version}"
  template     = "Vagrantfile.tpl"
}

build {
  sources = ["source.vagrant.cloud"]

  provisioner "shell" {
    execute_command   = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    expect_disconnect = true

    environment_vars = [
      "SALT_VERSION=${var.box_version}"
    ]

    scripts = [
      "./scripts/01.prepare.sh",
      "./scripts/02.vboxguest.sh",
      "./scripts/03.salt.sh",
    ]
  }

  post-processors {
    post-processor "manifest" {
      output     = "output/${var.box_name}-${var.box_version}.json"
      strip_path = false
    }

    post-processor "vagrant-cloud" {
      box_tag             = "${var.vagrant_account}/${var.box_name}-salt"
      version             = var.box_version
      keep_input_artifact = false
    }
  }
}
