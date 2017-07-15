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

puts "We want more..."
friends = ["Ary","Isacc","Fridgerator","Serdar","BrigeBOT xD"]
(0...5).each do |i|
  name = friends[i].to_s
  db.exec "insert into friend (name) values (?)", name
  puts "Hi " + name
end

puts "i forgot all of my friend, :O"
puts "reading memory. . .."
db.query "select name from friend" do |data|
  data.each do
    friend = data.read(String)
    puts friend + " is your friend"
  end
end

one = db.query_one? "select name from friend where name='Ary' limit 1", as:{String}
if one
  one + " is still my friend"
end

db.exec "delete from friend"

puts "Bye..."

puts "but, dont forget to visit http://jihantoro.net"
