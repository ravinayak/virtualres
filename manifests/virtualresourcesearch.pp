class virtualres::virtualresourcesearch {

  @file {'/etc/rescollectest-1.txt':
    ensure => file,
    owner  => 'rescollectest-1',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/etc/rescollectest-2.txt':
    ensure => file,
    owner  => 'rescollectest-2',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/etc/rescollectest-3.txt':
    ensure => file,
    owner  => 'rescollectest-3',
    group  => 'root',
    mode   => '0644',
    tag    => 'searchable'
  }
  @file {'/etc/rescollectest-4.txt':
    ensure => file,
    owner  => 'rescollectest-4',
    group  => 'root',
    mode   => '0644',
    tag    => 'nonsearchable'
  }
  @file {'/etc/rescollectest-5.txt':
    ensure => file,
    owner  => 'rescollectest-5',
    group  => 'root',
    mode   => '0644',
    tag    => 'nonsearchable'
  }

  @user {'rescollectest-1':
    ensure => present,
    tag    => 'nonsearchable'
  }
  @user {'rescollectest-2':
    ensure => present,
    tag    => 'nonsearchable'
  }
  @user {'rescollectest-3':
    ensure => present,
    tag    => 'nonsearchable'
  }
  @user {'rescollectest-4':
    ensure => present,
    tag    => 'searchable'
  }
  @user {'rescollectest-4':
    ensure => present,
    tag    => 'searchable'
  }

  @group {'rescollectgrouptest-1':
    ensure => present,
    gid    => 51005,
  }
  @group {'rescollectgrouptest-2':
    ensure => present,
    gid    => 51006,
  }
  @group {'rescollectgrouptest-3':
    ensure => present,
    gid    => 51007,
  }
  @group {'rescollectgrouptest-4':
    ensure => present,
    gid    => 51008,
  }

  # To run different versions of resource collectors for confirmation of its search parameters, destroy the resources created using
  # following bash commands:
  # sudo groupdel rescollectgrouptest-1 rescollectgrouptest-2 rescollectgrouptest-3 rescollectgrouptest-4
  # sudo userdel rescollectest-1 rescollectest-2 rescollectest-3 rescollectest-4 rescollectest-5
  # sudo rm -rf /etc/rescollecttest*

  # Ordering relationships defined below pick specific users on which files depend for creation. Those users are owners of files
  Group <| tag == searchable or tag == non-searchable |>
  User <| tag == nonsearchable |> -> File <| tag == searchable |>
  User <| tag == searchable |> -> File <| tag == nonsearchable |>

  # Ordering here using operators: and + != . Delete the groups, users, files created above

  # Group <| tag == searchable and tag == nonsearchable or tag == default |>
  # User <| tag == nonsearchable and tag == virtualres |> -> File <| tag == searchable |>
  # User <| tag == searchable and tag ==virtualres and tag == virtualresourcesearch |> -> File <| tag == nonsearchable |>

  # Must delete groups created above again before executing the following, delete users and files as well

  # Group <| |>
  # User <| |> -> File <| |>


}
