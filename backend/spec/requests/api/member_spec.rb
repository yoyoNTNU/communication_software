require 'rails_helper'
require 'support/authorized_helper'
require 'simplecov'
SimpleCov.start
RSpec.configure do |c|
    c.include AuthorizedHelper
end

RSpec.describe "Api::Members", type: :request do
  before do
    m=Member.new(user_id:"test",name:"測試",phone:"0912345678",email:"example@gmail.com",password:"Example123",is_login_mail:true)
    m.skip_confirmation!
    m.save
    post "/auth/member/sign_in",params:{email:"example@gmail.com",password:"Example123"}
    @header={Authorization: response.headers["Authorization"]}
  end

  let(:filepath) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '1.jpg'), 'image/jpg') }
  let(:invalid_filepath) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', '2.txt'), 'text/plain') }

  describe "PATCH /api/member/info" do
    example "succeed to update member info" do
      patch "/api/member/info",params:{photo:filepath,background:filepath,birthday:"2023/01/01",introduction:"我好師",name:"改名",is_login_mail:false},headers:@header
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": false,
            "message": "succeed to update member info",
            "data": Member.first
          }.to_json
        )
      ) 
    end

    example "failed to update member info(photo format error)" do
      patch "/api/member/info",params:{photo:invalid_filepath,background:filepath,birthday:"2023/01/01",introduction:"我好師",name:"改名"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update member info",
            "data": {
              "photo": [
                  "You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png"
              ]
            }
          }.to_json
        )
      ) 
    end

    example "failed to update member info(background format error)" do
      patch "/api/member/info",params:{photo:filepath,background:invalid_filepath,birthday:"2023/01/01",introduction:"我好師",name:"改名"},headers:@header
      expect(response).to have_http_status(400)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": true,
            "message": "failed to update member info",
            "data": {
              "background": [
                  "You are not allowed to upload \"txt\" files, allowed types: jpg, jpeg, gif, png"
              ]
            }
          }.to_json
        )
      ) 
    end

    example "failed to update member info(not login)" do
      patch "/api/member/info",params:{photo:filepath,background:invalid_filepath,birthday:"2023/01/01",introduction:"我好師",name:"改名"}
      expect_unauthorized(response)
    end
  end

  describe "GET /api/member/info" do
    example "succeed to get member info" do
      get "/api/member/info",headers:@header
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(
        JSON.parse( 
          {
            "error": false,
            "message": "succeed to get member info",
            "data": Member.first
          }.to_json
        )
      ) 
    end

    example "failed to get member info(not login)" do
      get "/api/member/info"
      expect_unauthorized(response)
    end
  end
end
