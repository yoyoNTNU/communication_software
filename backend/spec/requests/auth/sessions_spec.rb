require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
    c.include AuthorizedHelper
end

RSpec.describe "Auth::Sessions", type: :request do
  before do
    m=Member.new(user_id:"test1", name:"test", phone:"0912345678", email:"example1@gmail.com", password:"Example123", is_login_mail: true)
    m.skip_confirmation!
    m.save
    m=Member.new(user_id:"test2", name:"test", phone:"0912345679", email:"example2@gmail.com", password:"Example123", is_login_mail: false)
    m.skip_confirmation!
    m.save
  end

  describe "POST /auth/member/sign_in" do 
    example "succeed to sign in and sent email" do 
      post "/auth/member/sign_in",params:{email:"example1@gmail.com",password:"Example123"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test1")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example1@gmail.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345678")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example1@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】登入成功通知")
    end

    example "succeed to sign in and does not sent email" do 
      post "/auth/member/sign_in",params:{email:"example2@gmail.com",password:"Example123"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test2")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example2@gmail.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345679")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
    
    example "failed to sign in with incorrect password and sent email" do 
      post "/auth/member/sign_in",params:{email:"example1@gmail.com",password:""}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "Invalid login credentials. Please try again."
          }.to_json
        )
      )
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example1@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】登入失敗通知")
    end

    example "failed to sign in with incorrect password and does not sent email" do 
      post "/auth/member/sign_in",params:{email:"example2@gmail.com",password:""}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "Invalid login credentials. Please try again."
          }.to_json
        )
      )
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    example "failed to sign in with incorrect email" do 
      post "/auth/member/sign_in",params:{email:"",password:"Example123"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "Invalid login credentials. Please try again."
          }.to_json
        )
      )
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end

    example "failed to sign in with unconfirmed email" do
      m=Member.new(user_id:"new",name:"new",phone:"0900000000",email:"example3@gmail.com",password:"Example123", is_login_mail: true)
      m.save
      post "/auth/member/sign_in",params:{email: "example3@gmail.com", password:"Example123"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "A confirmation email was sent to your account at 'example3@gmail.com'. You must follow the instructions in the email before your account can be activated"
          }.to_json
        )
      )
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example3@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】登入失敗通知")
    end
  end

  describe "DELETE /auth/member/sign_out" do
    example "succeed to sign out" do
      post "/auth/member/sign_in",params:{email:"example1@gmail.com",password:"Example123"}
      @header={Authorization: response.headers["Authorization"]} 
      delete "/auth/member/sign_out", headers:@header
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": false,
            "message": "succeed to sign out",
            "data": {}
          }.to_json
        )
      )
    end

    example "failed to sign out" do
      post "/auth/member/sign_in",params:{email:"example1@gmail.com",password:"Example123"}
      @header={Authorization: response.headers["Authorization"]} 
      delete "/auth/member/sign_out", headers:@header
      delete "/auth/member/sign_out", headers:@header
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign out",
            "data": "User was not found or was not logged in."
          }.to_json
        )
      )
    end
  end
end