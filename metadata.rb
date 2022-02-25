name 'jira'
maintainer 'KLM Royal Dutch Airlines'
maintainer_email 'martijn.vanderkleijn@klm.com'
license 'Apache 2.0'
description 'Installs/Configures Atlassian JIRA.'
version '2.15.0'
source_url 'https://github.com/afklm/jira'
issues_url 'https://github.com/afklm/jira/issues'

recipe 'jira', 'Installs/configures Atlassian JIRA'
recipe 'jira::apache2', 'Installs/configures Apache 2 as proxy (ports 80/443)'
recipe 'jira::container_server_configuration', 'Configures container server for JIRA deployment'
recipe 'jira::database', 'Installs/configures MySQL/Postgres server, database, and user for JIRA'
recipe 'jira::installer', 'Installs/configures JIRA via installer'
recipe 'jira::autotune', 'Tries to autotune settings/attributes for performance'
recipe 'jira::standalone', 'Installs/configures JIRA via standalone archive'
recipe 'jira::sysv', 'Installs/configures JIRA SysV init service'

depends 'apache2', '<= 5.1.0'
depends 'ark', '< 5.1.0'
depends 'database'
depends 'java', '< 8.0'
depends 'mysql', '< 8.0.0'
depends 'mysql_connector'
depends 'mysql2_chef_gem'
depends 'postgresql', '< 7.0.0'
depends 'seven_zip', '< 3.0'
depends 'yum-mysql-community', '< 4.0.0'
depends 'mariadb', '< 4.0.0'

supports 'centos', '>= 6.0'
supports 'redhat', '>= 6.0'
supports 'ubuntu', '>= 12.04'

chef_version '< 13.0.0'
