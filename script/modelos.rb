#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)
require "connect"

require "rubygems"
require "active_record"

class Producto < ActiveRecord::Base
end

an_order = Producto.find_by_codigo("CIG-071903")
an_order.precio = 1000
an_order.save
