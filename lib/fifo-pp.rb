class FifoPP
  # atributos de la clase LifoPP
  attr_accessor :prices, :amount, :inventario, :ventas, :unidades_vendidas, :cogs

  # constructor de la clase, los parámetros los precios y la unidades de compra/venta
  def initialize(prices, amount)
    @prices = prices # arreglo de los precios
    @amount = amount # arreglo de unidades compra/venta
    @inventario = [] # arreglo donde se irá guardando los ingresos de materiales con su respectivo costo que sería igual al precio total / la cantidad a ingresar
    @ventas = 0 # acumulador de las ventas realizadas
    @unidades_vendidas = 0 # acumulador de las unidades vendidas
    @cogs = 0 # costo del stock
  end

  def calcular_fifo
    for i in 0..@amount.length - 1 # vamos a iterar los arreglos
      if @amount[i] > 0 # si el número es positivo, es un ingreso de inventario
        # ingreso
        inventario.push({ # agregamos el ingreso de material con el costo unitario del mismo
          :costo_unitario => prices[i],
          :cantidad => @amount[i]
        })
      else # si el número es negativo, vamos a descontar del inventario existente
        # venta
        cantidad = @amount[i]
        for k in 0..@inventario.length - 1 # iteramos el arreglo del inventario con el fin de vender primero lo que ingresó primero y a la par iremos calculando el costo de ese material saliente
          if (-1 * cantidad) > @inventario[k][:cantidad] # en caso que la cantidad a descontar sea mayor a la existencia del inventario que primero ingresó
            @cogs = @cogs + @inventario[k][:cantidad] * @inventario[k][:costo_unitario] # en caso que se tenga en el inventario que ingresó primero, se descuenta 
            if @inventario[k][:cantidad] > 0
              cantidad = cantidad + @inventario[k][:cantidad] # en caso que se tenga en el inventario que ingresó sigiuente, se descuenta 
              @inventario[k][:cantidad] = 0 # en caso que se tenga en el inventario que ingresó primero se quedó sin inventario
            end
          else # en caso que se tenga en el inventario que ingresó primero, se descuenta 
            @cogs = @cogs + (-1 * cantidad) * @inventario[k][:costo_unitario] # calculamos el cogs de del descuento
            @inventario[k][:cantidad] = @inventario[k][:cantidad] + cantidad # actualizamos el inventario
            cantidad = 0 
          end
        end
        @ventas = @ventas + @prices[i] * @amount[i] * -1 
      end
    end
  end

  # cálculo de utilidad luego de FIFO
  def get_utlidad
    @ventas - @cogs
  end

  def print
    "prices #{@prices} \namount #{@amount}\ninventario #{@inventario}\nventas #{@ventas}\ncogs #{cogs}"
  end
end