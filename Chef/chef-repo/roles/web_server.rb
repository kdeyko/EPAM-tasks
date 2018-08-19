name 'web_server'
description 'A role to configure our web servers'
run_list 'recipe[web::default]', 'recipe[web::php]', 'recipe[web::nginx]'
