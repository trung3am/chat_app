# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create(username: 'admin', password: '123' )
User.create(username: 'john', password: '123' )
User.create(username: 'doe', password: '123' )
User.create(username: 'minh', password: '123' )
User.create(username: 'trung', password: '123' )

GroupMessage.create(groupname: "group2")
GroupMessage.create(groupname: "group3")
GroupMessage.create(groupname: "group4")

Message.create(body: "Hello",user_id: 1, group_message_id: 2)
Message.create(body: "Alo",user_id: 2, group_message_id: 2)
Message.create(body: "test 231",user_id: 1, group_message_id: 2)
Message.create(body: "test mexs",user_id: 2, group_message_id: 3)
Message.create(body: "tesing",user_id: 3, group_message_id: 2)