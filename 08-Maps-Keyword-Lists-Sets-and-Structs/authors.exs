authors = [
  %{ name: "José", language: "Elixir" },
  %{ name: "Matz", language: "Ruby" },
  %{ name: "Larry", language: "Perl" }
]

languages_with_an_r = fn :get, collection, next_fn ->
  for row <- collection, String.contains?(row.language, "r"), do: next_fn.(row)
end

IO.inspect get_in(authors, [languages_with_an_r, :name])
