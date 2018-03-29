require 'rails_helper'

RSpec.describe Lead, type: :model do
  describe "Factory" do 
    it "should prove the factory works" do 
      expect(build :lead).to be_valid
    end 
  end   
end

