require 'rails_helper'

RSpec.describe Outreach, type: :model do
  describe "Factory" do 
    it "should prove the factory works" do 
      expect(build :outreach).to be_valid
    end 
  end   
end

