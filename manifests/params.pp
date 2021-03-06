# Class trusted_ca::params
#
class trusted_ca::params {
  $certificates_version = 'latest'

  case $::osfamily {
    'RedHat': {
      $path = [ '/usr/bin', '/bin']
      $update_command = 'update-ca-trust enable && update-ca-trust'
      $install_path = '/etc/pki/ca-trust/source/anchors'
      $certfile_suffix = 'crt'
      $certs_package = 'ca-certificates'
      case $::operatingsystem {
        'Amazon': {
          case $::operatingsystemmajrelease {
            '2015': {
            }
            default: {
              fail("${::osfamily} ${::operatingsystem} ${::operatingsystemmajrelease} has not been tested with this module.  Please feel free to test and report the results")
            }
          }
        }
        default: {
          case $::operatingsystemmajrelease {
            '6', '7': {
            }
            default: {
              fail("${::osfamily} ${::operatingsystemmajrelease} has not been tested with this module.  Please feel free to test and report the results")
            }
          }
        }
      }
    }
    'Debian': {
      $path = ['/bin', '/usr/bin', '/usr/sbin']
      $update_command = 'update-ca-certificates'
      $install_path = '/usr/local/share/ca-certificates'
      $certfile_suffix = 'crt'
      $certs_package = 'ca-certificates'

      case $::lsbdistcodename {
        'wheezy', 'jessie', 'lucid', 'precise', 'trusty', 'wily': {
        }
        default: {
          fail("${::osfamily} ${::operatingsystemrelease} has not been tested with this module.  Please feel free to test and report the results")
        }
      }
    }
    'Suse': {
      $certfile_suffix = 'pem'
      case $::operatingsystem {
        'SLES': {
          $path = ['/usr/bin']
          $update_command = 'c_rehash'
          $install_path = '/etc/ssl/certs'
          case $::operatingsystemmajrelease {
            '11': {
              $certs_package = 'openssl-certs'
            }
            default: {
              $certs_package = 'ca-certificates'
            }
          }
        }
        'OpenSuSE': {
          $path = ['/usr/sbin', '/usr/bin']
          $update_command = 'update-ca-certificates'
          $install_path = '/etc/pki/trust/anchors'
          $certs_package = 'ca-certificates'
        }
        default: {
          fail("${::osfamily}/${::operatingsystem} not supported")
        }
      }
    }
    default: {
      fail("${::osfamily}/${::operatingsystem} ${::operatingsystemrelease} not supported")
    }
  }
}
