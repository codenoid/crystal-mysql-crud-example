require "./jihantoro-cr-mysql/*"
require "db"
require "mysql"

db = DB.open "mysql://root:ayam@localhost:3306/jihantoro_crmysql"
at_exit { db.close }

friend = "Rouf"

puts "inserting data..."
db.exec "insert into friend (name) values (?)", friend # insert (Create) method

puts "reading data..."
myfriend = db.query_one "select name from friend limit 1", as:{String} # read (Read) method
puts "Hi " + myfriend

puts "updating data..."
newfriend = "Alficha"
db.exec "update friend set name=? where name=?", newfriend, myfriend # update (Update) method

puts "deleting data..."
db.exec "delete from friend where name=?", newfriend

puts "Done"
puts "dont forget to visit http://jihantoro.net"

db.close
