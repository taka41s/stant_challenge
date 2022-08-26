require "test_helper"

class ParserTest < ActiveSupport::TestCase
  RSpec.describe "Transactions", type: :request do
    before do
      @user = User.create!({id: 1, email: 'test', password: 'test'})
    end
  
    describe "POST /login" do
      it "sessions working" do
        post(login_path, params: {user: {email: 'test', password: 'test'}})
        expect(response).to have_http_status(302)
      end
    end
end