class LifoPP
  attr_accessor :prices, :amount, :inventario, :ventas, :unidades_vendidas, :cogs

  def initialize(prices, amount)
    @prices = prices
    @amount = amount
    @inventario = []
    @ventas = 0
    @unidades_vendidas = 0
    @cogs = 0
  end

  def calcular_inventario_inicial
    for i in 0..@amount.length - 1
      if @amount[i] > 0
        # actualizamos el inventario (cantidad y consto unitario)
        inventario.push({
          :costo_unitario => 1.0 * prices[i] / @amount[i],
          :cantidad => @amount[i]
        })
      end
    end
  end

  def calcular_ventas
    for i in 0..@amount.length - 1
      if @amount[i] <= 0
        @ventas = @ventas + @prices[i]
        @unidades_vendidas = @unidades_vendidas + (-1 * @amount[i])
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

  def get_utlidad
    @ventas - @cogs
  end

  def print
    "prices #{@prices} \namount #{@amount}\ninventario #{@inventario}\nventas #{@ventas}\ncogs #{cogs}"
  end
end