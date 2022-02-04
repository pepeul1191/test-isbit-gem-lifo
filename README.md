# LIFO

    $ ruby app.rb

Instalación de gema:

    $ gem build lifo-pp.gemspec
    $ gem install ./lifo-pp-0.0.0.gem

Uso de gema:

```ruby
require 'lifo-pp'

prices= [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount=[4, -2, -1 , 5, -0.5,  -0.5, -4.5]

lifo = LifoPP.new(prices, amount)
lifo.calcular_ventas
lifo.calcular_inventario_inicial

puts "inventario inicial"
puts lifo.inventario

lifo.calcular_lifo
puts "inventario final"
puts lifo.inventario
puts "cogs : #{lifo.cogs}"
puts "ventas : #{lifo.ventas}"
puts "utilidad : #{lifo.get_utlidad}"

```

---

Fuentes:

+ https://guides.rubygems.org/make-your-own-gem/
+ https://docs.github.com/es/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks
