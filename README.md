# LIFO

    $ ruby app.rb

Instalación de gema:

    $ gem build lifo-pp.gemspec
    $ gem install ./lifo-pp-0.0.1.gem

Publicar gema:

1. Crear cuenta en https://rubygems.org/sign_up
2. Pushear la gema

        
    $ gem push lifo-pp-0.0.1.gem

Uso de gema:

1. Agregar la dependencia

Gemfile

```
source 'https://rubygems.org'

gem 'lifo-pp'
```

2. Descargar la dependencia

    $ bundler install

3. Probar la gema con el siguiente código

```ruby
require 'lifo-pp'
require 'fifo-pp'

prices = [5000, 6500, 7000, 6000, 8000, 9000, 6500]
amount = [4   , -2  , -1  , 5   , -0.5, -0.5, -4.5]

lifo = LifoPP.new(prices, amount)
lifo.calcular_ventas
lifo.calcular_inventario_inicial

puts 'LIFO:'
puts "inventario inicial"
puts lifo.inventario

lifo.calcular_lifo
puts "inventario final"
puts lifo.inventario
puts "cogs : #{lifo.cogs}"
puts "ventas : #{lifo.ventas}"
puts "utilidad : #{lifo.get_utlidad}"

puts '+++++++++++++++++++++++++++++++++++++'
puts 'FIFO:'

fifo = FifoPP.new(prices, amount)
fifo.calcular_fifo
puts "cogs : #{fifo.cogs}"
puts "ventas : #{fifo.ventas}"
puts "utilidad : #{fifo.get_utlidad}"
puts fifo.inventario
```

Código en replit

https://replit.com/@pepeul1191/TrainedKnottyLeads#Gemfile

Rubygems

https://rubygems.org/gems/lifo-pp

---

Fuentes:

+ https://guides.rubygems.org/make-your-own-gem/
+ https://docs.github.com/es/get-started/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks
+ https://medium.com/@dhyegocalota/how-to-create-and-publish-your-first-configurable-ruby-gem-996ad50f0629