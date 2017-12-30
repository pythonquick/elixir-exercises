data = %{name: "Dave", state: "TX", likes: "Elixir"}
result = for key <- [:name, :likes] do
  %{^key => value} = data
  value
end
IO.inspect result
