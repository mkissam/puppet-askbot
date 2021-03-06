# == Class: askbot::site::http
# This class describes the http server configuration
class askbot::site::http (
  $site_root     = $::askbot::params::site_root,
  $site_template = 'askbot/askbot.vhost.erb',
  $site_name     = undef,
) {
  apache::vhost { $site_name:
    port     => 80,
    priority => 10,
    docroot  => $site_root,
    template => $site_template,
  }
}