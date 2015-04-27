# == Class: askbot::params
# This class holds the default parameters for askbot
class askbot::params {

  # askbot services
  $redis_enabled   = false
  $solr_enabled    = false

  # redis defaults
  $redis_prefix     = 'askbot'
  $redis_port       = undef
  $redis_max_memory = undef
  $redis_bind       = undef
  $redis_password   = undef

  # askbot source repository
  $askbot_repo     = 'https://github.com/ASKBOT/askbot-devel.git'
  $askbot_revision = 'master'

  # database settings
  $db_provider     = 'mysql'
  $db_name         = undef
  $db_user         = undef
  $db_password     = undef
  $db_host         = 'localhost'

  # directories
  $dist_root       = '/srv/dist'
  $site_root       = '/srv/askbot-site'

  # web server settings
  $www_user        = 'www-data'
  $www_group       = 'www-data'

  # custom theme
  $custom_theme_enabled = false
  $custom_theme_name    = undef
}