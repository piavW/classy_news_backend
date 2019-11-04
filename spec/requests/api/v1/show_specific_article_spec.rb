RSpec.describe 'GET specific article' do
  describe 'subscriber can view a specific article' do
    let(:subscriber) { create(:user, role: 'subscriber') }
    let(:credentials) { subscriber.create_new_auth_token }
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials) }
    let(:article) { create(:article) }

    before do  
      get "/api/v1/articles/#{article.id}", headers: headers
    end
   
    it 'returns one article' do
      expect(response_json.count).to eq 1
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'returns the correct data' do
      expected_response = {
          "id"=>article.id,
          "title"=>article.title,
          "content"=>article.content,
          "author"=>article.author,
          "publish_date"=>"#{article.created_at.strftime("%d").to_i.ordinalize} #{article.created_at.strftime("%B, %Y")}",
          "created_at"=>article.created_at.strftime("%F")
        }
        expect(response_json['article']).to eq(expected_response)
    end
  end

  describe 'gives error if user is not a subscriber' do
    let(:random_visitor) { create(:user, role: nil) }
    let(:credentials) { random_visitor.create_new_auth_token }
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}
    
    let(:article) { create(:article) }
    before do
      get "/api/v1/articles/#{article.id}", headers: headers
    end

    it 'gives error status when visitor tries to view article' do
      expect(response.status).to eq 401
    end

    it 'gives error message' do
      expect(response_json['error']).to eq 'You are not authorized!'
    end
  end
end