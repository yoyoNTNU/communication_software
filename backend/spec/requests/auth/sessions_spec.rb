require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
    c.include AuthorizedHelper
end

RSpec.describe "Api::Members", type: :request do
  before do
    m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@email.com",password:"Example123")
    m.skip_confirmation!
    m.save
  end

  describe "POST /auth/member/sign_in" do 
    example "succeed to sign in" do 
      post "/auth/member/sign_in",
      params:{email:"example@email.com",password:"Example123"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example@email.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345678")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
    end
    
    example "failed to sign in with incorrect password" do 
      post "/auth/member/sign_in",
      params:{email:"example@email.com",password:""}
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
end

RSpec.describe "Api::Members", type: :request do
  before do
    m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@email.com",password:"Example123")
    m.save
  end

  example "failed to sign in with uncertified email" do
    email = "example@email.com"
    post "/auth/member/sign_in",
    params:{email: email, password:"Example123"}
    expect(response).to have_http_status(401)
    expect(JSON.parse(response.body)).to eq(
      JSON.parse(
        {
          "error": true,
          "message": "failed to sign in",
          "data": "A confirmation email was sent to your account at '#{email}'. You must follow the instructions in the email before your account can be activated"
        }.to_json
      )
    )
  end
end