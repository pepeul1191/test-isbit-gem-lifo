prices= [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount=[100, -2, -1 , 5, -0.5,  -0.5, -4.5]

ii = 0
index = 0
ivalor = []

#puts amount
# puts amount.select{|x| x < 0}.sum
# puts amount.select{|x| x > 0}.sum
puts "venta, #{amount.select{|x| x < 0}.sum}"
puts "compras, #{amount.select{|x| x > 0}.sum}"

final = amount.select{|x| x > 0}.sum + amount.select{|x| x < 0}.sum
#puts final
ventas = 0
cogs = 0

costo = 0
inventario = []

for i in 0..amount.length - 1
  if amount[i] > 0
    # ingreso material, costo
    costo = costo + amount[i] * prices[i]
  else
    # venta
    ventas = ventas + -1 * (amount[i] * prices[i])
    cogs
  end
end

x = ventas - costo
puts x

"""
amount.each do |e|
  if amount[index] > 0
    costo = prices[index] * amount[index]
    ii = ii + amount[index]
    ivalor.push(
      {
        :costo_unitario => costo,
        :cantidad => amount[index]
      }
    )
  else
    # vendiendo
    venta = prices[index] * amount[index]
    index2 = 0
    ii = ii + amount[index]
    ivalor.each do |k|
      c = false
      if ivalor[index2][:cantidad] - amount[index] >= 0
        # descontar del primero 
        ivalor[index2][:cantidad] = ivalor[index2][:cantidad] - amount[index]
        cogs = cogs + prices[]
      elsif (ivalor[index2][:cantidad] + ivalor[index2 + 1][:cantidad]) - amount[index] >= 0 # 10
        # descontar primero y siguiente
        ivalor[index2][:cantidad] = 0 # 3 -> 0
        ivalor[index2 + 1][:cantidad] = amount[index] - ivalor[index2][:cantidad] # 10 -> 7
      end
      index2 = index2 + 1
    end
  end
  index = index + 1
end
"""