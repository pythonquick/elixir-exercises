ok! = fn
  {:ok, data} -> data
  {_, data} -> raise RuntimeError, message: "#{data}"
end


data = ok!.(File.open('/etc/passwd')) # Exists
IO.inspect data
data = ok!.(File.open('/etc/passwdxyz')) # Does not exists
IO.inspect data
