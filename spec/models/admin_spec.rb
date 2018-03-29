require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "Factory" do 
    it "should prove factory works for and can create multiple admins" do
      create :admin
      expect(build :admin).to be_valid
    end
  end   
end