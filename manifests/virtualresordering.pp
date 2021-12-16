class virtualres::virtualresordering {
  include virtualres::virtualuser
  include virtualres::virtualfile
  User <| tag==neo5 |> -> File <| tag ==virtualfiles |>
}
