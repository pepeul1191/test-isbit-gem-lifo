class LifoPP
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

  def calcular_inventario_inicial
    for i in 0..@amount.length - 1
      if @amount[i] > 0
        # actualizamos el inventario (cantidad y consto unitario)
        inventario.push({
          :costo_unitario => prices[i],
          :cantidad => @amount[i]
        })
      end
    end
  end

  def calcular_ventas
    for i in 0..@amount.length - 1
      if @amount[i] <= 0
        @ventas = @ventas + @prices[i] * @amount[i] * -1 # acumulamos los precios de venta
        @unidades_vendidas = @unidades_vendidas + (-1 * @amount[i]) # acumulamos las cantidades
      end
    end
  end

  def calcular_lifo
    for i in 0..@inventario.length - 1 # vamos a recorer el inventario para evaluar el LIFO
      k = @inventario.length - 1 - i # indice para recorrer primero lo último en ingresar
      if @unidades_vendidas <= @inventario[k][:cantidad] # en caso que el inventario actual pueda abastecer la venta, entonces...
        @cogs = @cogs +  @unidades_vendidas * @inventario[k][:costo_unitario] # actualizamos el cogs con el costo de ese inventario
        @inventario[k][:cantidad] = @inventario[k][:cantidad] - @unidades_vendidas # actualizamos la cantidad del inventario
        @unidades_vendidas = 0 # actulizamos la cantidad de unidades a vender restantes
      elsif @unidades_vendidas >= 0 && @unidades_vendidas > @inventario[k][:cantidad] # en caso que el inventario actual no pueda abastecer la venta, entonces...
        @cogs = @cogs + @inventario[k][:cantidad] * @inventario[k][:costo_unitario] # actualizamos el cogs con el costo de ese inventario
        @unidades_vendidas = @unidades_vendidas - @inventario[k][:cantidad] # actulizamos la cantidad de unidades a vender restantes
        @inventario[k][:cantidad] = 0 # actulizamos la cantidad del inventario
      end
    end
  end

  # cálculo de utilidad luego de LIFO
  def get_utlidad
    @ventas - @cogs
  end

  def print
    "prices #{@prices} \namount #{@amount}\ninventario #{@inventario}\nventas #{@ventas}\ncogs #{cogs}"
  end
end