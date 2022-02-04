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
      :costo => prices[i] / amount[i],
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
        cogs = cogs + (-1 * cantidad) * inventario[k][:costo]
        inventario[k][:cantidad] = inventario[k][:cantidad] + cantidad
        cantidad = 0
      end
    end
    ventas = ventas + prices[i]
  end
end


puts 'Inventario final:'
puts inventario
puts ventas
puts "cogs = #{cogs}"
