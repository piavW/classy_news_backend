RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  context 'with valid credentials' do
    it 'returns a user and token' do
      post '/api/v1/auth', params: { nickname: 'craft',
                                     email: 'example@craftacademy.se',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers

      expect(response_json['status']).to eq 'success'
      expect(response.status).to eq 200
    end
  end

  context 'returns an error message when user submits' do
    it 'non-matching password confirmation' do
      post '/api/v1/auth', params: { nickname: 'luca',
                                     email: 'example@craftacademy.se',
                                     password: 'password',
                                     password_confirmation: 'wrong_password'
                                  }, headers: headers

      expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      expect(response.status).to eq 422
    end

    it 'an invalid email address' do
      post '/api/v1/auth', params: { nickname: 'nickname',
                                     email: 'example@craft',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers

      expect(response_json['errors']['email']).to eq ['is not an email']
      expect(response.status).to eq 422
    end

    it 'an already registered email' do
      FactoryBot.create(:user, nickname: 'becca',
                               email: 'example@craftacademy.se',
                               password: 'password',
                               password_confirmation: 'password')

      post '/api/v1/auth', params: { nickname: 'faraz',
                                     email: 'example@craftacademy.se',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers
      expect(response_json['errors']['email']).to eq ['has already been taken']
      expect(response.status).to eq 422
    end
  end
end