require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
    c.include AuthorizedHelper
end

RSpec.describe "Auth::Resgistrations", type: :request do
	describe 'POST /auth/member' do 
		example 'succeed to sign up' do
      #註冊
			post '/auth/member', params:{user_id:"test", email:"example@gmail.com", password:"Example123", password_confirmation:"Example123", name:"test", phone:"0987654321"}
			expect(response).to have_http_status(200)
			parsed_body = JSON.parse(response.body)
			expect(parsed_body["data"]["user_id"]).to eq("test")
			expect(parsed_body["data"]["name"]).to eq("test")
			expect(parsed_body["data"]["email"]).to eq("example@gmail.com")
			expect(parsed_body["data"]["phone"]).to eq("0987654321")
			expect(parsed_body["error"]).to eq(false) 
			expect(parsed_body["message"]).to eq("succeed to sign up")
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】帳號啟用確認信")
      #未驗證登入失敗
      post "/auth/member/sign_in",params:{email: "example@gmail.com", password:"Example123"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "A confirmation email was sent to your account at 'example@gmail.com'. You must follow the instructions in the email before your account can be activated"
          }.to_json
        )
      )
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(ActionMailer::Base.deliveries.last.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.last.subject).to eq("【Express Message】登入失敗通知")
      #驗證後登入成功
      confirmation_token = Member.first.confirmation_token
      get '/auth/member/confirmation',params:{confirmation_token:confirmation_token}
      post "/auth/member/sign_in",params:{email: "example@gmail.com", password:"Example123"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test")
			expect(parsed_body["data"]["name"]).to eq("test")
			expect(parsed_body["data"]["email"]).to eq("example@gmail.com")
			expect(parsed_body["data"]["phone"]).to eq("0987654321")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
      expect(ActionMailer::Base.deliveries.count).to eq(3)
      expect(ActionMailer::Base.deliveries.last.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.last.subject).to eq("【Express Message】登入成功通知")
    end

		example 'failed to sign up: invalid password format' do
			post '/auth/member', params:{user_id:"test", email:"example@gmail.com", password:"111111", password_confirmation:"111111", name:"test", phone:"0987654321"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"password": [
								"at least one uppercase, lowercase letter, number and can not include other special character"
							],
							"full_messages": [
								"Password at least one uppercase, lowercase letter, number and can not include other special character"
							]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: password is too short' do
			post '/auth/member', params:{user_id:"test", email:"example@gmail.com", password:"Ab1", password_confirmation:"Ab1", name:"test", phone:"0987654321"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"password": [
								"is too short (minimum is 6 characters)"
							],
							"full_messages": [
								"Password is too short (minimum is 6 characters)"
							]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: password confirmation does not match password' do
			post '/auth/member', params:{user_id:"test", email:"example@gmail.com", password:"Example1", password_confirmation:"Example2", name:"test", phone:"0987654321"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
								"password_confirmation": [
										"doesn't match Password"
								],
								"full_messages": [
										"Password confirmation doesn't match Password"
								]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: fields can not be blank' do
			post '/auth/member', params:{user_id:"", email:"", password:"Example1", password_confirmation:"Example1", name:"", phone:""}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"email": [
								"can't be blank"
							],
							"user_id": [
								"can't be blank"
							],
							"name": [
								"can't be blank"
							],
							"phone": [
								"can't be blank"
							],
							"full_messages": [
								"Email can't be blank",
								"User can't be blank",
								"Name can't be blank",
								"Phone can't be blank"
							]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: email has been taken' do
			m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@gmail.com",password:"Example123")
			m.skip_confirmation!
			m.save
			post '/auth/member', params:{user_id:"test1", email:"example@gmail.com", password:"Example1", password_confirmation:"Example1", name:"test1", phone:"0987654321"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"email": [
								"has already been taken"
							],
							"full_messages": [
								"Email has already been taken",
							]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: user_id has been taken' do
			m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@gmail.com",password:"Example123")
			m.skip_confirmation!
			m.save
			post '/auth/member', params:{user_id:"test", email:"example1@gmail.com", password:"Example1", password_confirmation:"Example1", name:"test1", phone:"0987654321"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"user_id": [
							"has already been taken"
							],
						"full_messages": [
							"User has already been taken"
							]
						}
					}.to_json
				)
			)
		end

		example 'failed to sign up: phone has been taken' do
			m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@gmail.com",password:"Example123")
			m.skip_confirmation!
			m.save
			post '/auth/member', params:{user_id:"test1", email:"example1@gmail.com", password:"Example1", password_confirmation:"Example1", name:"test1", phone:"0912345678"}
			expect(response).to have_http_status(401)
			expect(JSON.parse(response.body)).to eq(
				JSON.parse( 
					{
						"error": true,
						"message": "failed to sign up",
						"data": {
							"phone": [
							"has already been taken"
							],
						"full_messages": [
							"Phone has already been taken"
							]
						}
					}.to_json
				)
			)
		end
	end
end