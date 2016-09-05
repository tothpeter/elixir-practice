
# output1 = for x <- [1,2,3,4,5,6], x < 4, do: x
# IO.inspect output1

# output2 = for x <- [1,2], y <- [3,4], x < 4, do: x * y
# IO.inspect output2

defmodule Shipping do
  def total_amount(order, tax_rates) do
    # tax_rate = tax_rates[order[:ship_to]] || 0
    tax_rate = Keyword.get(tax_rates, order[:ship_to], 0)
    order[:net_amount] + order[:net_amount] * tax_rate
  end

  def add_total_ammount(order, tax_rates) do
    # order ++ [total_amount: total_amount(order, tax_rates)]
    Keyword.put(order, :total_amount, total_amount(order, tax_rates))
  end

  def final_orders(orders, tax_rates) do
    orders |> Enum.map(&add_total_ammount(&1, tax_rates))
  end

  def final_orders2(orders, tax_rates) do
    for order <- orders, do: add_total_ammount(order, tax_rates)
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 120, ship_to: :NC, net_amount:  50.00 ] ]

Shipping.final_orders(orders, tax_rates)
  |> IO.inspect

Shipping.final_orders2(orders, tax_rates)
  # |> IO.inspect
