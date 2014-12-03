# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all															
Product.create(name:'BIELA CORTA MOD 06E',code:'BIE-1212',marc:'Copeland',quantity:100,price:2.0,imageurl:'logo/BIE-1212.gif',model:'06E',flagmis:'no')
Product.create(name:'BIELA LARGA MOD 07D',code:'BIE-1213',marc:'Carrier',quantity:100,price:2.0,imageurl:'logo/BIE-1213.gif',model:'07D',flagmis:'no')
Product.create(name:'BIELA LARGA MOD 06D',code:'BIE-1214',marc:'Bitzer',quantity:100,price:2.0,imageurl:'logo/BIE-1214.gif',model:'06D',flagmis:'no')
