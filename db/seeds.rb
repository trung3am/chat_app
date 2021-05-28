# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create(username: 'System', password: 'trungdeptrai', email:'tqtrung1209@gmail.com' )
User.create(username: 'john', password: '123', email:'john@gmail.com' )
User.create(username: 'doe', password: '123', email:'doe@gmail.com' )
User.create(username: 'minh', password: '123' , email:'minh@gmail.com')
User.create(username: 'trung', password: '123' , email:'trung@gmail.com')

GroupMessage.create(groupname: "Lobby", groupadmin_id: 1,bilateral: false)
GroupMessage.create(groupname: "group3", bilateral: false)

Message.create(body: "Hello",user_id: 1, group_message_id: 1)
Message.create(body: "Hello",user_id: 2, group_message_id: 1)
Message.create(body: "Hello",user_id: 3, group_message_id: 1)
Message.create(body: "Hello",user_id: 4, group_message_id: 1)
Message.create(body: "Alo",user_id: 5, group_message_id: 1)
Message.create(body: "test 231",user_id: 1, group_message_id: 2)
Message.create(body: "test mexs",user_id: 2, group_message_id: 2)
Message.create(body: "tesing",user_id: 3, group_message_id: 2)