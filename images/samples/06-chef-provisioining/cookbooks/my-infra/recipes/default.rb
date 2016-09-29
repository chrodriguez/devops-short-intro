#Crea un rol en chef-server
chef_role 'web-server' do
  run_list ["recipe[apt]","recipe[web-server]"]
end

#Crea vms en paralelo
machine_batch do
  machine 'web-01' do
    run_list ['role[web-server]']
  end

  machine 'web-02' do
    run_list ['role[web-server]']
  end
end

# Una vm más luego de que se hayan creado las dos anteriores
machine 'proxy' do
  run_list ['recipe[myhaproxy]']
end
