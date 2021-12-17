class virtualres::realizevirtualbeforedefine{


  # realize before virtual resource is defined

  realize File['/etc/defineprerealize.txt']

  #Resource Collector collecting before definition of file

  File <| tag == searchablefiles |>

  @file { '/etc/defineprerealize.txt':
    ensure => file,
  }

  @file { '/etc/definebeforesearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles, searchablefiles'
  }

  # If a virtual resource is defined before its realization, following 2 uce cases are possible:
  #   1. realize: If you use realize a resource before it is defined, it leads to a compilation failure
  #   2. Resource Collector: since this is based on search, if the resource is not defined before search is performed, nothing results

  # resource collector before and after files are declared

  File <| tag == defaultfiles |>

  # realize post declaration of virtual resource

  realize File['/etc/definebeforesearch.txt']

  @file {'/etc/defineaftersearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles',
  }

  @file {'/etc/definepostrealize.txt':
    ensre => file,
  }
}
