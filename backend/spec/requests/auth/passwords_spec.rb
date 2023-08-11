require 'rails_helper'
require 'uri'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
  c.include AuthorizedHelper
end

RSpec.describe "Auth::Passwords", type: :request do
  before do
    m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@gmail.com",password:"Example123")
    m.skip_confirmation!
    m.save
    post "/auth/member/sign_in",params:{email:"example@gmail.com",password:"Example123"}
    @header={Authorization: response.headers["Authorization"]}
    ActionMailer::Base.deliveries.clear
  end

  describe "PUT /auth/member/password (modify)" do
    example "succeed to update password" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example124", current_password:"Example123"},headers:@header
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": false,
            "message": "succeed to update password",
            "data": "Your password has been successfully updated."
          }.to_json
        )
      ) 
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】密碼更改通知信")
      post "/auth/member/sign_in",params:{email:"example@gmail.com",password:"Example124"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example@gmail.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345678")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(ActionMailer::Base.deliveries.last.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.last.subject).to eq("【Express Message】登入成功通知")
    end

    example "failed to update password: not sign in" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example124", current_password:"Example123"}
      expect_unauthorized(response)
    end

    example "failed to update password: invalid password format" do
      put "/auth/member/password",params:{password:"111111",password_confirmation:"111111", current_password:"Example123"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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

    example "failed to update password: password confirmation does not match password" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example125", current_password:"Example123"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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

    example "failed to update password: new password is too short" do
      put "/auth/member/password",params:{password:"Ex4",password_confirmation:"Ex4", current_password:"Example123"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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

    example "failed to update password: current password is incorrect" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example124", current_password:"Example121"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
            "data": {
              "current_password": [
                "is invalid"
              ],
              "full_messages": [
                "Current password is invalid"
              ]
            }
          }.to_json
        )
      ) 
    end
  end

  
  describe "POST /auth/member/password" do
    example "succeed to sent reset password email" do
      post "/auth/member/password",params:{email:"example@gmail.com",redirect_url:"http://127.0.0.1:3000/"}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": false,
            "message": "succeed to sent reset password email",
            "data": "An email has been sent to 'example@gmail.com' containing instructions for resetting your password."
          }.to_json
        )
      ) 
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】重設密碼通知信")
    end

    example "failed to sent reset password email without redirect url" do
      post "/auth/member/password",params:{email:"example@gmail.com"}
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to sent reset password email",
            "data": "Missing redirect URL."
          }.to_json
        )
      ) 
    end

    example "failed to sent reset password email without email" do
      post "/auth/member/password",params:{redirect_url:"http://127.0.0.1:3000/"}
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to sent reset password email",
            "data": "You must provide an email address."
          }.to_json
        )
      ) 
    end

    example "failed to sent reset password email email not exist" do
      post "/auth/member/password",params:{email:"example1@gmail.com",redirect_url:"http://127.0.0.1:3000/"}
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to sent reset password email",
            "data": "Unable to find user with email 'example1@gmail.com'."
          }.to_json
        )
      ) 
    end
  end

  describe "PUT /auth/member/password (reset)" do
    before do
      post "/auth/member/password",params:{email:"example@gmail.com",redirect_url:"http://127.0.0.1:3000/"}
      mail_body = ActionMailer::Base.deliveries.first.body.to_s
      match = mail_body.match(/<a\s+href="([^"]+)">重設密碼<\/a>/)
      get match[1]
      uri = URI.parse(response.headers['Location']) 
      @token = URI.decode_www_form(uri.query).to_h
      ActionMailer::Base.deliveries.clear
    end

    example "succeed to reset password" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example124"},headers:@token
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": false,
            "message": "succeed to update password",
            "data": "Your password has been successfully updated."
          }.to_json
        )
      ) 
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      expect(ActionMailer::Base.deliveries.first.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.first.subject).to eq("【Express Message】密碼更改通知信")
      post "/auth/member/sign_in",params:{email:"example@gmail.com",password:"Example124"}
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]["user_id"]).to eq("test")
      expect(parsed_body["data"]["name"]).to eq("test")
      expect(parsed_body["data"]["email"]).to eq("example@gmail.com")
      expect(parsed_body["data"]["phone"]).to eq("0912345678")
      expect(parsed_body["error"]).to eq(false) 
      expect(parsed_body["message"]).to eq("succeed to sign in")
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(ActionMailer::Base.deliveries.last.to).to include("example@gmail.com")
      expect(ActionMailer::Base.deliveries.last.subject).to eq("【Express Message】登入成功通知")
    end

    example "failed to reset password: invalid password format" do
      put "/auth/member/password",params:{password:"111111",password_confirmation:"111111"},headers:@token
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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

    example "failed to reset password: password confirmation does not match password" do
      put "/auth/member/password",params:{password:"Example124",password_confirmation:"Example125"},headers:@token
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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

    example "failed to reset password: new password is too short" do
      put "/auth/member/password",params:{password:"Ex4",password_confirmation:"Ex4"},headers:@token
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update password",
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
  end
end