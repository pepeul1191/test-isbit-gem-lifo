prices= [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount=[4, -2, -1 , 5, -0.5,  -0.5, -4.5]

ii = 0
index = 0
ivalor = []

#puts amount
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
    inventario.push({
      :costo => prices[i],
      :cantidad => amount[i]
    })
  else
    # venta
    cantidad = amount[i]
    for k in 0..inventario.length - 1
      if (-1 * cantidad) > inventario[k][:cantidad]
        cogs = cogs + inventario[k][:cantidad] * inventario[k][:costo]
        if inventario[k][:cantidad] > 0
          cantidad = cantidad + inventario[k][:cantidad]
          inventario[k][:cantidad] = 0
        end
      else
        cogs = cogs + cantidad * inventario[k][:costo]
        inventario[k][:cantidad] = inventario[k][:cantidad] + cantidad
        cantidad = 0
      end
    end
    ventas = ventas + -1 * (amount[i] * prices[i])
  end
end

puts inventario
puts cogs

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