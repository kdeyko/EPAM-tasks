name 'web'
description 'A role to configure our web servers'
run_list 'recipe[apt]', 'recipe[nginx]'
