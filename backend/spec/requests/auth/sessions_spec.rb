require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
    c.include AuthorizedHelper
end

RSpec.describe "Auth::Sessions", type: :request do
  before do
    m=Member.new(user_id:"test", name:"test", phone:"0912345678", email:"example@gmail.com", password:"Example123", is_login_mail: false)
    m.skip_confirmation!
    m.save
  end

  describe "POST /auth/member/sign_in" do 
    example "succeed to sign in" do 
      post "/auth/member/sign_in",
      params:{email:"example@gmail.com",password:"Example123"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example@gmail.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345678")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
    end
    
    example "failed to sign in with incorrect password" do 
      post "/auth/member/sign_in",
      params:{email:"example@gmail.com",password:""}
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
    end

    example "failed to sign in with incorrect email" do 
      post "/auth/member/sign_in",
      params:{email:"",password:"Example123"}
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
    end
  end
  
  describe "POST /auth/member/sign_in" do
    example "failed to sign in with uncertified email" do
      m=Member.new(user_id:"test1",name:"test1",phone:"09123456789",email:"example1@gmail.com",password:"Example124", is_login_mail: false)
      m.save
      post "/auth/member/sign_in",
      params:{email: "example1@gmail.com", password:"Example124"}
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse(
          {
            "error": true,
            "message": "failed to sign in",
            "data": "A confirmation email was sent to your account at 'example1@gmail.com'. You must follow the instructions in the email before your account can be activated"
          }.to_json
        )
      )
    end
  end

  describe "DELETE /auth/member/sign_out" do
    example "succeed to sign out" do
      m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@gmail.com",password:"Example123")
      m.skip_confirmation!
      m.save
      post "/auth/member/sign_in",params:{email:"example@gmail.com",password:"Example123"}
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
  end
end