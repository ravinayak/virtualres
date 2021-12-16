class virtualres::virtualuser {
  @user{'neo5':
    ensure => present,
    tag    => 'neo5'
  }
}
