RSpec.describe 'GET articles index' do
  describe 'lists a collection of articles' do
  let!(:articles) { 2.times { create(:article) } }

    before do
      get '/api/v1/articles'
    end

    it 'returns 2 articles' do      
      expect(response_json['articles'].count).to eq 2
    end
  end

  describe 'returns error if there\'s no articles in the database' do
    before do
      get '/api/v1/articles'
    end

    it 'returns error status' do
      expect(response.status).to eq 404
    end

    it 'returns error message' do
      expect(response_json["error_message"]).to eq "There are no articles here"
    end
  end
end