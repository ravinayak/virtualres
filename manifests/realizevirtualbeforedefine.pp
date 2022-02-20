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

  # Virtual resources are ideally defined in 1 class in and used in another class in same module. If we define all the virtual resources 
  # as a top level module, and include it in another module, this will lead to code away from data which is an anti pattern
  # Including virtualresource module so we can see different search scenarios of resource collectors. If we realize a virtual file resource 
  # before it is defined in the same file, then it actually creates that resource. There is no compilation error. Evluation order of virtual 
  # resources does not impact its realizability in the same file, but if you declare virtual 
  # resource in another file, and include it, then the order of realizing the resource and definition does matter
  # To realize a virtual resource which has been declared in another class, we must realize post inclusion. If you realize a virtual resource
  # which has not been included through another class yet, this will lead to compilation error
  #
  # If a virtual resource is defined in 1 module before its realization in another module, following 2 use cases are possible:
  #   1. realize: Evaluation order independent virtual resources are realized even if we include them before they are declared
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
