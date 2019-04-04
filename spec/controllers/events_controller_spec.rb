require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views

  let!(:event) { create(:event) }

  describe 'GET #index' do
    before(:each) do
      get :index, format: :json
    end

    let(:result) do
      {
        'title' => event.title,
        'start' => event.starts_at.strftime('%Y-%m-%d'),
        'end' => event.ends_at.strftime('%Y-%m-%d'),
      }
    end

    it 'returns events' do
      expect(json_response).to include(result)
    end
  end

  describe 'POST #create' do
    let(:new_event_params) { {} }

    subject { post :create, event: new_event_params, format: :json }

    context 'when event parameters has invalid value' do
      before(:each) do
        subject
      end

      let(:new_event_params) do
        {
          title: '',
          starts_at: Date.today.strftime('%Y-%m-%d'),
          ends_at: (Date.today + 1.day).strftime('%Y-%m-%d')
        }
      end

      it 'returns an error' do
        expect(response.status).to eq(422)
        expect(json_response).to eq({ "title" => ["can't be blank"] })
      end
    end

    context 'when event parameters are correct' do
      let(:new_event_params) do
        {
          title: 'Event title',
          starts_at: Date.today.strftime('%Y-%m-%d'),
          ends_at: (Date.today + 1.day).strftime('%Y-%m-%d')
        }
      end

      it 'returns a created event' do
        expect { subject }.to change { Event.count }.by(1)
      end

      it 'returns a created event' do
        subject

        expect(response.status).to eq(200)
        expect(json_response['title']).to include(new_event_params[:title])
        expect(json_response['starts_at']).to include(new_event_params[:starts_at])
        expect(json_response['ends_at']).to include(new_event_params[:ends_at])
      end
    end
  end

end
