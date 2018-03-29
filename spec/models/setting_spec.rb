require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe "Factory" do 
    it "should prove the factory works" do 
      expect(build :setting).to be_valid
    end 
  end   
end

