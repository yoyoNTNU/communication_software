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
    
    example "failed to sign in" do 
      post "/auth/member/sign_in",
      params:{email:"",password:""}
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