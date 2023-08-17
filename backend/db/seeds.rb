p "DB seeding"
p "clean DB"

MessageReader.destroy_all
Message.destroy_all
ChatroomMember.destroy_all
Chatroom.destroy_all
Friendship.destroy_all
FriendRequest.destroy_all
Group.destroy_all
Member.destroy_all

p "create member"
m1=Member.new(user_id:"test1",name:"範例1號",phone:"0900000000",email:"example1@gmail.com",password:"Example123",is_login_mail:true)
m1.skip_confirmation!
m1.save
m2=Member.new(user_id:"test2",name:"範例2號",phone:"0911111111",email:"example2@gmail.com",password:"Example123",is_login_mail:true)
m2.skip_confirmation!
m2.save
m3=Member.new(user_id:"test3",name:"範例3號",phone:"0922222222",email:"example3@gmail.com",password:"Example123",is_login_mail:true)
m3.skip_confirmation!
m3.save
m4=Member.new(user_id:"test4",name:"範例4號",phone:"0933333333",email:"example4@gmail.com",password:"Example123",is_login_mail:true)
m4.skip_confirmation!
m4.save
m5=Member.new(user_id:"test5",name:"範例5號",phone:"0944444444",email:"example5@gmail.com",password:"Example123",is_login_mail:true)
m5.skip_confirmation!
m5.save

p "create friendship"
fs1=Friendship.create(member:m1,friend:m2)
fs2=Friendship.create(member:m1,friend:m3)
fs3=Friendship.create(member:m2,friend:m3)
fs4=Friendship.create(member:m2,friend:m4)
fs5=Friendship.create(member:m2,friend:m5)
fs6=Friendship.create(member:m3,friend:m5)

p "create group"
g1=Group.create(name:"G1",photo:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg')),background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')))
g2=Group.create(name:"G2",photo:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg')),background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')))
g3=Group.create(name:"G3",photo:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg')),background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')))
g4=Group.create(name:"G4",photo:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg')),background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')))


p "create chatroom"
c1=Chatroom.find_by(type_:"friend",type_id:fs1.id)
c2=Chatroom.find_by(type_:"friend",type_id:fs2.id)
c3=Chatroom.find_by(type_:"friend",type_id:fs3.id)
c4=Chatroom.find_by(type_:"friend",type_id:fs4.id)
c5=Chatroom.find_by(type_:"friend",type_id:fs5.id)
c6=Chatroom.find_by(type_:"friend",type_id:fs6.id)
c7=Chatroom.find_by(type_:"group",type_id:g1.id)
c8=Chatroom.find_by(type_:"group",type_id:g2.id)
c9=Chatroom.find_by(type_:"group",type_id:g3.id)
c10=Chatroom.find_by(type_:"group",type_id:g4.id)

p "create chatroom_member"
ChatroomMember.create(member:m1,chatroom:c7,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m2,chatroom:c7,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m3,chatroom:c7,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m4,chatroom:c7,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m3,chatroom:c8,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m1,chatroom:c8,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m5,chatroom:c8,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m4,chatroom:c9,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m1,chatroom:c9,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)
ChatroomMember.create(member:m1,chatroom:c10,background:Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '3.jpg')),isPinned:true,isDisabled:false)

p "create message"
Message.create(chatroom:c1,member:m1,type_:"string",content:"hello1")
Message.create(chatroom:c9,member:m1,type_:"string",content:"hello2")
Message.create(chatroom:c2,member:m1,type_:"string",content:"hello3")
Message.create(chatroom:c1,member:m2,type_:"string",content:"hello4")
Message.create(chatroom:c3,member:m3,type_:"string",content:"hello5")
Message.create(chatroom:c3,member:m2,type_:"string",content:"hello6")
Message.create(chatroom:c4,member:m4,type_:"string",content:"hello7")
Message.create(chatroom:c5,member:m2,type_:"string",content:"hello8")
Message.create(chatroom:c6,member:m2,type_:"string",content:"hello9")
Message.create(chatroom:c7,member:m3,type_:"string",content:"hello10")
Message.create(chatroom:c7,member:m4,type_:"string",content:"hello11")
Message.create(chatroom:c7,member:m1,type_:"string",content:"hello12")
Message.create(chatroom:c7,member:m1,type_:"string",content:"hello13")
Message.create(chatroom:c8,member:m3,type_:"string",content:"hello14")
Message.create(chatroom:c8,member:m5,type_:"string",content:"hello15")
Message.create(chatroom:c9,member:m4,type_:"string",content:"hello16")
Message.create(chatroom:c9,member:m4,type_:"string",content:"hello17")
Message.create(chatroom:c7,member:m2,type_:"string",content:"hello18")
Message.create(chatroom:c10,member:m1,type_:"string",content:"hello19")
Message.create(chatroom:c10,member:m1,type_:"string",content:"hello20")

p "DB seeded"