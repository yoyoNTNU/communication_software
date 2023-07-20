require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
  c.include AuthorizedHelper
end

RSpec.describe "Api::Passwords", type: :request do
  before do
    m=Member.new(user_id:"test",name:"test",phone:"0912345678",email:"example@email.com",password:"Example123")
    m.skip_confirmation!
    m.save
    post "/auth/member/sign_in",params:{email:"example@email.com",password:"Example123"}
    @header={Authorization: response.headers["Authorization"]}
  end

  describe "PUT /auth/member/password" do
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

    example "failed to update password: password confirmation doesn\'t match password" do
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
end