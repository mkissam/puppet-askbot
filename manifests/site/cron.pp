# == Class: askbot::site::cron
# This class describes the askbot scheduled tasks
class askbot::site::cron (
  $site_root = $::askbot::params::site_root,
) {
  file { "${site_root}/cron":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => File[$site_root],
  }
}