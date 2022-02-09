# datos de entrada
prices = [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount = [4   , -2  , -1  , 5   , -0.5, -0.5, -4.5]
# cálculo de unidades vendidas y compradas
puts "venta, #{amount.select{|x| x < 0}.sum}"
puts "compras, #{amount.select{|x| x > 0}.sum}"
final = amount.select{|x| x > 0}.sum + amount.select{|x| x < 0}.sum

ventas = 0 # acumulador de las ventas realizadas
cogs = 0 # acumulador de costo de mi inventario vendido
inventario = [] # arreglo donde se irá guardando los ingresos de materiales con su respectivo costo que sería igual al precio total / la cantidad a ingresar

for i in 0..amount.length - 1
  if amount[i] > 0
    # actualizamos el inventario (cantidad y consto unitario)
    inventario.push({
      :costo_unitario => prices[i],
      :cantidad => amount[i]
    })
  else # calculamos las ventas totales
    ventas = ventas + prices[i] * amount[i] * -1
  end
end
# calculamos el total de unidades
unidades_vendidas = -1 * amount.select{|x| x < 0}.sum
puts 'Inventario inicial:' # comprobamos el inventario inicial antes del LIFO
puts inventario
# puts inventario
puts "unidades vendidas = #{unidades_vendidas}"
for i in 0..inventario.length - 1 # vamos a recorer el inventario para evaluar el LIFO
  k = inventario.length - 1 - i # indice para recorrer primero lo último en ingresar
  if unidades_vendidas <= inventario[k][:cantidad] # en caso que el inventario actual pueda abastecer la venta, entonces...
    cogs = cogs +  unidades_vendidas * inventario[k][:costo_unitario] # actualizamos el cogs con el costo de ese inventario
    inventario[k][:cantidad] = inventario[k][:cantidad] - unidades_vendidas # actualizamos la cantidad del inventario
    unidades_vendidas = 0 # actulizamos la cantidad de unidades a vender restantes
  elsif unidades_vendidas >= 0 && unidades_vendidas > inventario[k][:cantidad] # en caso que el inventario actual no pueda abastecer la venta, entonces...
    cogs = cogs + inventario[k][:cantidad] * inventario[k][:costo_unitario] # actualizamos el cogs con el costo de ese inventario
    unidades_vendidas = unidades_vendidas - inventario[k][:cantidad] # actulizamos la cantidad de unidades a vender restantes
    inventario[k][:cantidad] = 0 # actulizamos la cantidad del inventario
  end
end
# respuestas
puts 'Inventario final:'
puts inventario
puts "ventas = #{ventas}"
puts "cogs = #{cogs}"
puts "ventas - cogs = #{ventas - cogs}"