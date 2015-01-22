require 'spec_helper'

describe StaticController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response.status).to be 200
    end
  end
end
