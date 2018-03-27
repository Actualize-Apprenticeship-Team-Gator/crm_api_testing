require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "Factory" do 
    it "should prove the factory works" do 
      expect(build :event).to be_valid
    end 
  end   
end

