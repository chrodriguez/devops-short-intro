with_driver 'aws:mikroways:us-west-2'

with_machine_options({
  bootstrap_options: {
    image_id: "ami-b1a652d1",
    instance_type: "m1.small",
    key_name: "car", # If not specified, this will be used and generated
  },
  transport_address_location: :public_ip,
  ssh_username: "ubuntu"
})
