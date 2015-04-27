# == Class: askbot
# This class sets up an askbot site
#
# == Parameters
#
# == Actions
class askbot (
  $dist_root       = $::askbot::params::dist_root,
  $site_root       = $::askbot::params::site_root,
  $askbot_revision = $::askbot::params::askbot_revision,
  $askbot_repo     = $::askbot::params::askbot_repo,
  $www_group       = $::askbot::params::www_group,
  $www_user        = $::askbot::params::www_user,
  $db_provider     = $::askbot::params::db_provider,
  $db_name         = $::askbot::params::db_name,
  $db_user         = $::askbot::params::db_user,
  $db_password     = $::askbot::params::db_password,
  $db_host         = $::askbot::params::db_host,
  $redis_enabled = $::askbot::params::redis_enabled,
  $redis_prefix = $::askbot::params::redis_prefix,
  $redis_port = $::askbot::params::redis_port,
  $redis_max_memory = $::askbot::params::redis_max_memory,
  $redis_bind = $::askbot::params::redis_bind,
  $redis_password = $::askbot::params::redis_password,
  $site_name = undef,
  $custom_theme_enabled = $::askbot::params::custom_theme_enabled,
  $custom_theme_name = $::askbot::params::custom_theme_name,
) inherits askbot::params {

  class { 'askbot::install':
    db_provider     => $db_provider,
    dist_root       => $dist_root,
    askbot_repo     => $askbot_repo,
    askbot_revision => $askbot_revision,
    redis_enabled   => $redis_enabled,
  }

  if !defined(File[$dist_root]) {
    file { $dist_root:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
  }

  vcsrepo { "${dist_root}/askbot":
    ensure   => latest,
    provider => git,
    revision => $askbot_revision,
    source   => $askbot_repo,
    require  => [ File[$dist_root], Package['git'] ],
  }

  class { 'askbot::config':
    site_root            => $site_root,
    dist_root            => $dist_root,
    www_group            => $www_group,
    db_provider          => $db_provider,
    db_name              => $db_name,
    db_user              => $db_user,
    db_password          => $db_password,
    db_host              => $db_host,
    redis_enabled        => $redis_enabled,
    redis_prefix         => $redis_prefix,
    redis_port           => $redis_port,
    redis_max_memory     => $redis_max_memory,
    redis_bind           => $redis_bind,
    redis_password       => $redis_password,
    site_name            => $site_name,
    custom_theme_enabled => $custom_theme_enabled,
    custom_theme_name    => $custom_theme_name,
    require              => [ Vcsrepo["${dist_root}/askbot"], Class['askbot::install'] ],
  }
}