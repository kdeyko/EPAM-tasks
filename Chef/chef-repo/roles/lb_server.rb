name 'lb_server'
description 'A role to configure our load-balancer server'
run_list 'recipe[lb::default]', 'recipe[lb::nginx]'
