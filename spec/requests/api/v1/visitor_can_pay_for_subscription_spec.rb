require 'stripe_mock'

RSpec.describe Api::V1::SubscriptionsController, type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop }

  let(:new_subscriber) { create(:user) }
  let(:credentials) { new_subscriber.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'Payment posts successfully' do
    before do
      post '/api/v1/subscriptions', 
      params: { stripeToken: StripeMock.generate_card_token },
      headers: headers
    end

    it 'return status 200' do
      expect(response.status).to eq 200
    end

    it 'returns success message' do
      expect(response_json['message']).to eq 'Your payment was successful'
    end

    it 'user role changes to subscriber when payment is successful' do 
      new_subscriber.reload
      expect(new_subscriber.subscriber?).to eq true
    end
  end

  describe 'Payment is declined' do
    describe 'because payment lacks stripe token' do
      before do
        post '/api/v1/subscriptions',
        params: { stripeToken: nil },
        headers: headers
      end

      it 'returns status 402' do
        expect(response.status).to eq 402
      end

      it 'returns error message' do
        expect(response_json['errors']).to eq 'No stripe token detected'
      end

      it 'user does not have the role of subscriber' do
        expect(new_subscriber.subscriber?).to eq false
      end
    end

    describe 'because payment had invalid stripe token' do
      before do
        post '/api/v1/subscriptions',
        params: { stripeToken: 'invalid_token' },
        headers: headers
      end

      it 'returns status 402' do
        expect(response.status).to eq 402
      end

      it 'return error message' do
        expect(response_json['errors']).to eq 'Invalid token id: id'   
      end
    end
  end
end