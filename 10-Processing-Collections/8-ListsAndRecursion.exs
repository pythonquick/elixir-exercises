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
  def main do
    orders = [
      [id: 123, ship_to: :NC, net_amount: 100.00 ],
      [id: 124, ship_to: :OK, net_amount: 35.50 ],
      [id: 125, ship_to: :TX, net_amount: 24.00 ],
      [id: 126, ship_to: :TX, net_amount: 44.80 ],
      [id: 127, ship_to: :NC, net_amount: 25.00 ],
      [id: 128, ship_to: :MA, net_amount: 10.00 ],
      [id: 129, ship_to: :CA, net_amount: 102.00 ],
      [id: 130, ship_to: :NC, net_amount: 50.00 ]]
    tax_rates = [NC: 0.075, TX: 0.08]
    #IO.inspect Listo.applyTaxToOrders_v1 orders, tax_rates
    IO.inspect Listo.applyTaxToOrders_v2 orders, tax_rates
  end
end


Main.main
