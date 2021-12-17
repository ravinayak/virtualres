class virtualres::realizevirtualbeforedefine{

  file { '/etc/definebeforesearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles'
  }
  File <| tag == defaultfiles |>

  file {'/etc/defineaftersearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles',
  }
}
