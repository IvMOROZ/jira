default['jira']['home_path']          = '/var/atlassian/application-data/jira'
default['jira']['install_path']       = '/opt/atlassian/jira'
default['jira']['install_type']       = 'installer'
default['jira']['version']            = '8.11.1'
default['jira']['flavor']             = 'software'
default['jira']['user']               = 'jira'
default['jira']['group']              = 'jira'
default['jira']['backup_when_update'] = false
default['jira']['ssl']                = false
default['init_package'] = 'systemd'


# Types include: 'mixed', 'dedicated', 'shared'
# 'mixed'     - JIRA and DB run on the same system
# 'dedicated' - JIRA has the system all to itself
# 'shared'    - JIRA shares the system with the DB and other applications
default['jira']['autotune']['enabled'] = false
default['jira']['autotune']['type']    = 'mixed'

# If you don't want total system memory to be automatically discovered through
# Ohai, uncomment the following line and set your own value in kB.
# default['jira']['autotune']['total_memory'] = '1048576kB' # 1024m

# Defaults are automatically selected from version via helper functions
default['jira']['url']      = nil
default['jira']['checksum'] = nil

# Data bag where credentials and other sensitive data could be stored (optional)
default['jira']['data_bag_name'] = 'jira'
default['jira']['data_bag_item'] = 'jira'

default['jira']['apache2']['template_cookbook']  = 'jira'
default['jira']['apache2']['access_log']         = ''
default['jira']['apache2']['error_log']          = ''
default['jira']['apache2']['port']               = 80
default['jira']['apache2']['virtual_host_name']  = node['fqdn']
default['jira']['apache2']['virtual_host_alias'] = node['hostname']

default['jira']['apache2']['ssl']['access_log']       = ''
default['jira']['apache2']['ssl']['error_log']        = ''
default['jira']['apache2']['ssl']['chain_file']       = ''
default['jira']['apache2']['ssl']['port']             = 443

default['apache']['listen'] |= [ "*:#{node['jira']['apache2']['port']}", "*:#{node['jira']['apache2']['ssl']['port']}" ]

case node['platform_family']
when 'rhel'
  default['jira']['apache2']['ssl']['certificate_file'] = '/etc/pki/tls/certs/localhost.crt'
  default['jira']['apache2']['ssl']['key_file']         = '/etc/pki/tls/private/localhost.key'
else
  default['jira']['apache2']['ssl']['certificate_file'] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  default['jira']['apache2']['ssl']['key_file']         = '/etc/ssl/private/ssl-cert-snakeoil.key'
end

default['jira']['database']['host']     = '127.0.0.1'
default['jira']['database']['name']     = 'jira'
default['jira']['database']['password'] = 'changeit'
default['jira']['database']['type']     = 'postgresql'
default['jira']['database']['user']     = 'jira'
# Setting pool sizes for DB
default['jira']['database']['pool-min-size'] = '20'
default['jira']['database']['pool-max-size'] = '20'
default['jira']['database']['pool-max-idle'] = '20'
default['jira']['database']['pool-max-wait'] = '30000'

if node['jira']['database']['type'] == 'postgresql'
  default['postgresql']['config_pgtune']['db_type']      = 'web'       # postgresql tuning for web (assumes postgresql on same host)
  default['postgresql']['config_pgtune']['total_memory'] = '1048576kB' # limit max memory of the postgresql server to 1G

  # Needed for postgresql unfortunately
  case node['platform_family']
  when 'debian'
    default['apt']['compile_time_update'] = true
  end
end

# Sets mysql root password if mysql is installed on same host
if node['jira']['database']['type'] == 'mysql' && node['jira']['database']['host'] == '127.0.0.1'
  default['mysql']['server_root_password'] = 'changethistosomethingsensible'
end

# Default is automatically selected from database type via helper function
default['jira']['database']['port'] = nil

default['jira']['jvm']['minimum_memory']  = '256m'
default['jira']['jvm']['maximum_memory']  = '768m'
default['jira']['jvm']['maximum_permgen'] = '256m'
default['jira']['jvm']['java_opts']       = ''
default['jira']['jvm']['support_args']    = ''

default['jira']['tomcat']['port'] = '8080'

default['jira']['crowd_sso']['enabled']        = false
default['jira']['crowd_sso']['sso_appname']    = 'jira'
default['jira']['crowd_sso']['sso_password']   = 'changethistosomethingsensible'
default['jira']['crowd_sso']['crowd_base_url'] = 'http://localhost:8095/crowd/'

default['postgresql']['pg_gem']['version'] = '0.21.0'

default['java']['jdk_version'] = '8'
default['java']['install_flavor'] = 'oracle'
default['java']['jdk']['8']['x86_64']['url'] = 'http://distrib.prls.net/linux/jdk-8u202-linux-x64.tar.gz'
default['java']['jdk']['8']['x86_64']['checksum'] = '9a5c32411a6a06e22b69c495b7975034409fa1652d03aeb8eb5b6f59fd4594e0'
default['java']['oracle']['accept_oracle_download_terms'] = true

#default['postgresql']['version'] = '12.4'
#default['postgresql']['enable_pgdg_yum'] = true
#default['postgresql']['pgdg']['repo_rpm_url']['12']['centos']['7']['x86_64'] = 'https://download.postgresql.org/pub/repos/yum/12/redhat/rhel-7.8-x86_64/postgresql12-12.4-1PGDG.rhel7.x86_64.rpm'
