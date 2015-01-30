require "spec_helper"

describe StaticController do
  describe 'routing' do
    it 'roures to #index' do
      expect(get('/')).to route_to('static#index')
    end
  end
end
