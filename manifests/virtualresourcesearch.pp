class virtualres::virtualresourcesearch {

  @file {'/codetestfiles/rescollectest-1.txt':
    ensure => file,
    owner  => 'rescollectest-1',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/codetestfiles/rescollectest-2.txt':
    ensure => file,
    owner  => 'rescollectest-2',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/codetestfiles/rescollectest-3.txt':
    ensure => file,
    owner  => 'rescollectest-3',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/codetestfiles/rescollectest-4.txt':
    ensure => file,
    owner  => 'rescollectest-4',
    group  => 'root',
    mode   => '0644',
    tag    => 'nonsearchable'
  }
  @file {'/codetestfiles/rescollectest-5.txt':
    ensure => file,
    owner  => 'rescollectest-5',
    group  => 'root',
    mode   => '0644',
    tag    => 'nonsearchable'
  }

  @user {'rescollectest-1':
    ensure => present,
    tag    => 'nonsearchable',
    gid    => 51005,
  }
  @user {'rescollectest-2':
    ensure => present,
    tag    => 'nonsearchable',
    gid    => 51006,
  }
  @user {'rescollectest-3':
    ensure => present,
    tag    => 'nonsearchable',
    gid    => 51007,
  }
  @user {'rescollectest-4':
    ensure => present,
    tag    => 'searchable',
    gid    => 51008,
  }
  @user {'rescollectest-5':
    ensure => present,
    tag    => 'searchable',
  }

  @group {'rescollectgrouptest-1':
    ensure => present,
    gid    => 51005,
    tag    => 'searchable',
  }
  @group {'rescollectgrouptest-2':
    ensure => present,
    gid    => 51006,
    tag    => 'searchable',
  }
  @group {'rescollectgrouptest-3':
    ensure => present,
    gid    => 51007,
    tag    => 'nonsearchable',
  }
  @group {'rescollectgrouptest-4':
    ensure => present,
    gid    => 51008,
    tag    => 'nonsearchable',
  }

  # To run different versions of resource collectors for confirmation of its search parameters, destroy the resources created using
  # following bash commands:
  # sudo groupdel rescollectgrouptest-1 rescollectgrouptest-2 rescollectgrouptest-3 rescollectgrouptest-4
  # sudo userdel rescollectest-1 rescollectest-2 rescollectest-3 rescollectest-4 rescollectest-5
  # sudo rm -rf /codetestfiles/rescollecttest*

  # Ordering relationships defined below pick specific users on which files depend for creation. Those users are owners of files
  # Test Use Case 1: Resource Collectors independently chained
  # -------------------------------------------------------------------------------------------
  # Group <| tag == searchable or tag == non-searchable |>
  # User <| tag == nonsearchable |> -> File <| tag == searchable |>
  # User <| tag == searchable |> -> File <| tag == nonsearchable |>

  # Ordering here using operators: and + != . Delete the groups, users, files created above
  # Test Use Case 2: Resource Collectors using different operators for search
  # default is a reserved word in Puppet and will throw an error if used without double quotes as shown below
  # Group <| tag == searchable and tag == nonsearchable or tag == "default" |>
  # -------------------------------------------------------------------------------------------

  # Group <| tag == searchable or tag == nonsearchable or tag == defaultfiles |>
  # User <| tag == nonsearchable and tag == virtualres |> -> File <| tag == searchable |>
  # User <| tag == searchable and tag ==virtualres and tag == virtualresourcesearch |> -> File <| tag == nonsearchable |>

  # Ordering here is based on the evaluation of code in order in which it is written
  # Test Use Case 3: Resource Collectors without the use of any search expression, matches all instances of that resource in this file
  # Here the ordering of Group and User is not specified, however, user autorequires a group, and therefore the order will be set 
  # automatically
  # Must delete groups created above again before executing the following, delete users and files as well

  Group <| |>
  User <| |> -> File <| |>


}
