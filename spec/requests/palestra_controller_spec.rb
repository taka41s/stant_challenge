require 'rails_helper'

RSpec.describe "PalestrasController", type: :request do
  
  describe "POST /upload" do
    before :each do
      @file = fixture_file_upload('/document.txt', 'text/txt')
    end

    it "checks if the given post path is receiving the document with a list and parsing with success" do
      post('/upload', params: {document: @file})
      expect(response).to have_http_status(200)
    end
  end
  
end