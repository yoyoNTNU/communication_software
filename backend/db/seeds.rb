p "DB seeding"
p "clean DB"

Message.destroy_all
Chatroom.destroy_all
Friend.destroy_all
Group_member.destroy_all
Group.destroy_all
Member.destroy_all

p "create member"
m=Member.new(user_id:"test1",name:"範例1號",phone:"0900000000",email:"example1@gmail.com",password:"Example123",is_login_mail:true)
m.skip_confirmation!
m.save
m=Member.new(user_id:"test2",name:"範例2號",phone:"0911111111",email:"example2@gmail.com",password:"Example123",is_login_mail:true)
m.skip_confirmation!
m.save
m=Member.new(user_id:"test3",name:"範例3號",phone:"0922222222",email:"example3@gmail.com",password:"Example123",is_login_mail:true)
m.skip_confirmation!
m.save
m=Member.new(user_id:"test4",name:"範例4號",phone:"0933333333",email:"example4@gmail.com",password:"Example123",is_login_mail:true)
m.skip_confirmation!
m.save
m=Member.new(user_id:"test5",name:"範例5號",phone:"0944444444",email:"example5@gmail.com",password:"Example123",is_login_mail:true)
m.skip_confirmation!
m.save

p "DB seeded"