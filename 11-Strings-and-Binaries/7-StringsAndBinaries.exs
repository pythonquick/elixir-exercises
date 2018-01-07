defmodule Listo do
  def applyTaxToOrders_v1(orders, stateTaxRates) do
    Enum.map(orders, fn(order) ->
      state = order[:ship_to]
      net_amt = order[:net_amount]
      tax = Keyword.get(stateTaxRates, state, 0)
      total_amt = net_amt * (1+tax)
      Keyword.put(order, :total_amount, total_amt);
    end)
  end

  def applyTaxToOrders_v2(orders, stateTaxRates) do
    for [id: id, ship_to: state, net_amount: net_amt] <- orders,
        state_tax = Keyword.get(stateTaxRates, state, 0),
        total_amt = net_amt * (1 + state_tax),
        do: [id: id, ship_to: state, net_amount: net_amt, total_amount: total_amt]
  end
end


defmodule Main do
  def orders_from_file(file_name) do
    {:ok, file} = File.open(file_name, [:read])
    IO.read(file, :line) # consume the heading line
    Enum.map(IO.stream(file, :line), &(_parse_order_line(&1)))
  end

  defp _parse_order_line(order_line) do
    [id, state, amount] = String.trim(order_line) |> String.split(",")
    state = String.to_atom(String.slice(state, 1..-1))
    [
      id: String.to_integer(id),
      ship_to: state,
      net_amount: String.to_float(amount)
    ]
  end

  def main do
    tax_rates = [NC: 0.075, TX: 0.08]
    orders = 
      orders_from_file('orders.txt')
      |> Listo.applyTaxToOrders_v2(tax_rates)

    IO.inspect orders
  end
end


Main.main

