# datos de entrada
prices= [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount=[4, -2, -1 , 5, -0.5,  -0.5, -4.5]
# cálculo de unidades vendidas y compradas
puts "venta, #{amount.select{|x| x < 0}.sum}"
puts "compras, #{amount.select{|x| x > 0}.sum}"
final = amount.select{|x| x > 0}.sum + amount.select{|x| x < 0}.sum

ventas = 0 # acumulador de las ventas realizadas
cogs = 0 # acumulador de costo de mi inventario vendido
inventario = [] # arreglo donde se irá guardando los ingresos de materiales con su respectivo costo que sería igual al precio total / la cantidad a ingresar

for i in 0..amount.length - 1
  if amount[i] > 0
    inventario.push({
      :costo => prices[i] / amount[i],
      :cantidad => amount[i]
    })
  else
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

# respuestas
puts 'Inventario final:'
puts inventario
puts "ventas - #{ventas}"
puts "cogs = #{cogs}"
puts "ventas - cogs = #{ventas - cogs}"