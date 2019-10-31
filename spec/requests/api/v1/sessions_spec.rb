RSpec.describe 'Sessions', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'POST /auth/sign_in' do
    it 'valid credentials returns user' do
      post '/auth/sign_in', params: { email: user.email,
                                             password: user.password
                                          }, headers: headers

      expected_response = {
        'data' => {
          'id' => user.id, 'uid' => user.email, 'email' => user.email,
          'provider' => 'email', 'role' => 'subscriber', 'name' => nil, 'nickname' => user.nickname,
          'image' => nil, 'allow_password_change' => false, 'city' => user.city, 'country' => user.country
        }    
      }

      expect(response_json).to eq expected_response
    end

    it 'invalid password returns error message' do
      post '/auth/sign_in', params: { email: user.email,
                                             password: 'wrong_password'
                                          }, headers: headers

      expect(response_json['errors'])
        .to eq ['Invalid login credentials. Please try again.']

      expect(response.status).to eq 401
    end

    it 'invalid email returns error message' do
      post '/auth/sign_in', params: { email: 'wrong@email.com',
                                             password: user.password
                                          }, headers: headers

      expect(response_json['errors'])
        .to eq ['Invalid login credentials. Please try again.']

      expect(response.status).to eq 401
    end
  end
end