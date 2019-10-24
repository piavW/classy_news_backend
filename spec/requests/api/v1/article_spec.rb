RSpec.describe 'List articles', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  context 'with valid articles' do
    it 'returns a list of articles' do
      get '/api/v1/articles', params: { title: 'Trump Impeachment',
                                     content: 'Orange douchebag goes down',
                                     author: 'CIA'
                                  }, headers: headers
      expect(response.status).to eq 200

    end
  end
end