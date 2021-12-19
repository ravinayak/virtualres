class virtualres::virtualresordering {
  include virtualres::virtualuser
  include virtualres::virtualfile
  User <| tag==neo55 |> -> File <| tag ==virtualfiles |>
}
