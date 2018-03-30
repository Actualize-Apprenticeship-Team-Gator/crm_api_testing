require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "Factory" do 
    it "should prove factory works for and can create multiple admins" do
      create :admin
      expect(build :admin).to be_valid
    end
  end  

  describe '#record_progress' do 
    before :each do 
      @admin = create(:admin)
    end

    context 'when admin has daily log from today' do
      before do
        @daily_log = DailyProgressLog.create(admin_id: @admin.id, date: Date.today)  
      end

      it 'increments the :processed attribute by 1' do 
        @admin.record_progress(create(:lead))
        expect(@daily_log.reload.processed).to eq 1
      end

      context 'with connected lead' do
        it 'increments the :connects attribute by 1' do
          @admin.record_progress(create(:lead, connected: true))
          expect(@daily_log.reload.connects).to eq 1
        end
      end

      context 'with non-connected lead' do
        it 'increments the :connects attribute by 0' do
          @admin.record_progress(create(:lead))
          expect(@daily_log.reload.connects).to eq 0
        end
      end

      context 'when lead has appointment date' do 
        it 'increment :sets attribute by 1' do 
          @admin.record_progress(create(:lead))
          expect(@daily_log.reload.sets).to eq 1 
        end
      end

      context 'when lead does not have an appointment date' do 
        it 'increment :sets attribute by 0' do 
          @admin.record_progress(create(:lead, appointment_date: nil))
          expect(@daily_log.reload.sets).to eq 0
        end
      end
    end

    context 'when admin does not have daily log ' do 
      it 'increments the :processed attribute by 1' do 
        @admin.record_progress(create(:lead))
        expect(@admin.daily_progress_logs.last.reload.processed).to eq 1
      end

      context 'with connected lead' do
        it 'increments the :connects attribute by 1' do
          @admin.record_progress(create(:lead, connected: true))
          expect(@admin.daily_progress_logs.last.reload.connects).to eq 1
        end
      end

      context 'with non-connected lead' do
        it 'increments the :connects attribute by 0' do
          @admin.record_progress(create(:lead))
          expect(@admin.daily_progress_logs.last.reload.connects).to eq 0
        end
      end

      context 'when lead has appointment date' do 
        it 'increment :sets attribute by 1' do 
          @admin.record_progress(create(:lead))
          expect(@admin.daily_progress_logs.last.reload.sets).to eq 1 
        end
      end

      context 'when lead does not have an appointment date' do 
        it 'increment :sets attribute by 0' do 
          @admin.record_progress(create(:lead, appointment_date: nil))
          expect(@admin.daily_progress_logs.last.reload.sets).to eq 0
        end
      end
    end
  end 
end
