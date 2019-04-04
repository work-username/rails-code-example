require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    context 'if :title is not defined' do
      let(:event) { build(:event, title: nil) }

      it 'event is invalid' do
        expect(event.valid?).to eq(false)
      end
    end

    context 'if :starts_at is not defined' do
      let(:event) { build(:event, starts_at: nil) }

      it 'event is invalid' do
        expect(event.valid?).to eq(false)
      end
    end

    context 'if :ends_at is not defined' do
      let(:event) { build(:event, ends_at: nil) }

      it 'event is invalid' do
        expect(event.valid?).to eq(false)
      end
    end

    context 'if :ends_at is less than :starts_at' do
      let(:event) { build(:event, starts_at: Date.today, ends_at: Date.today - 1.day) }
      let(:error_message) { 'The start date should be less or equal than the end date' }

      it 'event is invalid' do
        expect(event.valid?).to eq(false)
        expect(event.errors[:base]).to include(error_message)
      end
    end

    context 'if all necessary fields are defined and correct' do
      let(:event) { build(:event) }

      context 'when :starts_at less than :ends_at' do
        it 'event is valid' do
          expect(event.valid?).to eq(true)
        end
      end

      context 'when :starts_at equal to :ends_at' do
        let(:event) { build(:event, starts_at: Date.today, ends_at: Date.today) }

        it 'event is valid' do
          expect(event.valid?).to eq(true)
        end
      end
    end
  end
end
