name 'db'
maintainer 'Kirill Deyko'
maintainer_email 'kdeyko@gmail.com'
license 'GPL-3.0'
description 'Installs/Configures database server'
long_description 'Installs/Configures database servers with master-slave replication'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)
supports 'ubuntu'

depends 'mysql', '~> 8.5.1'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/kdeyko/EPAM-tasks/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#

source_url 'https://github.com/kdeyko/EPAM-tasks/tree/master/Chef/chef-repo/cookbooks/db'
