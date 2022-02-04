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

for i in 0..amount.length - 1 # vamos a iterar los arreglos
  if amount[i] > 0 # si el número es positivo, es un ingreso de inventario
    # ingreso
    inventario.push({ # agregamos el ingreso de material con el costo unitario del mismo
      :costo => prices[i] / amount[i],
      :cantidad => amount[i]
    })
  else # si el número es negativo, vamos a descontar del inventario existente
    # venta
    cantidad = amount[i]
    for k in 0..inventario.length - 1 # iteramos el arreglo del inventario con el fin de vender primero lo que ingresó primero y a la par iremos calculando el costo de ese material saliente
      if (-1 * cantidad) > inventario[k][:cantidad] # en caso que la cantidad a descontar sea mayor a la existencia del inventario que primero ingresó
        cogs = cogs + inventario[k][:cantidad] * inventario[k][:costo] # en caso que se tenga en el inventario que ingresó primero, se descuenta 
        if inventario[k][:cantidad] > 0
          cantidad = cantidad + inventario[k][:cantidad] # en caso que se tenga en el inventario que ingresó sigiuente, se descuenta 
          inventario[k][:cantidad] = 0 # en caso que se tenga en el inventario que ingresó primero se quedó sin inventario
        end
      else # en caso que se tenga en el inventario que ingresó primero, se descuenta 
        cogs = cogs + (-1 * cantidad) * inventario[k][:costo] # calculamos el cogs de del descuento
        inventario[k][:cantidad] = inventario[k][:cantidad] + cantidad # actualizamos el inventario
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