Vagrant.configure(2) do |config|
  config.vm.define "source", autostart: false do |source|
    source.vm.box = "{{.SourceBox}}"
    config.ssh.insert_key = {{.InsertKey}}
  end

  config.vm.define "output" do |output|
    output.vm.box = "{{.BoxName}}"
    output.vm.box_url = "file://package.box"
    config.ssh.insert_key = {{.InsertKey}}
  end

  config.vm.provider "virtualbox" do |v|
    v.customize [ "modifyvm", :id, "--uart1", "off" ]
    v.customize [ "modifyvm", :id, "--uart2", "off" ]
    v.customize [ "modifyvm", :id, "--uart3", "off" ]
    v.customize [ "modifyvm", :id, "--uart4", "off" ]
    v.memory = 4096
    v.cpus = `nproc`.to_i
  end
end
