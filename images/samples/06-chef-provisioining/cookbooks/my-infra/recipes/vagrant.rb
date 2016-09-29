require 'chef/provisioning/vagrant_driver'

with_driver 'vagrant'

vagrant_box 'chef/ubuntu-14.04'

with_machine_options(
  vagrant_options: {
    'vm.box' => 'chef/ubuntu-14.04',
    'vm.network' => ':private_network, type: "dhcp"'
  }
)
