name "web-server"
description "My web server"
run_list ["recipe[apt]","recipe[web-server]"]
