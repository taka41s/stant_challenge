require 'rails_helper'

RSpec.describe "PalestrasController", type: :request do
  describe "POST /upload" do
    it "checks if the given post path is receiving the document with a list and parsing with success" do
      list = 'document.txt'

      post('/upload', params: {document: list})
      expect(response).to have_http_status(200)
    end
  end
end