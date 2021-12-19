class virtualres::realizevirtualbeforedefine{

  @file { '/codetestfiles/defineprerealize.txt':
    ensure => file,
  }

  @file { '/codetestfiles/definebeforesearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles, searchablefiles'
  }

  # Virtual resources are ideally defined in 1 module and used in another through mostly include function
  # Including virtualresource module so we can see different search scenarios of resource collectors. If we realize a virtual file resource 
  # before it is defined in the same file, then it actually creates that resource. There is no compilation error. One possible explanation 
  # could be that evluation order of virtual resources does not impact its realizability in the same file, but if you declare virtual 
  # resource in another file, and include it, then the order of realizing the resource and definition does matter
  #
  # If a virtual resource is defined in 1 module before its realization in another module, following 2 uce cases are possible:
  #   1. realize: If you use realize a resource before it is defined, it should lead to compilation failure, but it does not, it works 
  #               perfectly
  #   2. Resource Collector: since this is based on search, if the resource is not defined before search is performed, nothing results

  # resource collector before and after files are declared

  File <| tag == defaultfiles |>

  # realize post declaration of virtual resource

  realize File['/codetestfiles/definebeforesearch.txt']

  @file {'/codetestfiles/defineaftersearch.txt':
    ensure => file,
    owner  => 'vagrant',
    group  => 'vagrant',
    mode   => '0644',
    tag    => 'defaultfiles',
  }

  @file {'/codetestfiles/definepostrealize.txt':
    ensre => file,
  }
}
