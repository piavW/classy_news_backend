RSpec.describe 'GET specific article' do
  describe 'subscriber can view a specific article' do
    let(:article) { create(:article) }
    let(:user_subscriber) { create(:user, role: 'subscriber') }

    before do
      get "/api/v1/article/#{article.id}"
    end

    it 'returns one article' do
      expect(response_json['article'].count).to eq 1
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'returns the correct data' do
      article_date = "#{Article.created_at.strftime("%d").to_i.ordinalize} #{Article.created_at.strftime("%B, %Y")}"

      expected_response = [
        {
          "id"=>Article.id,
          "title"=>Article.title,
          "content"=>Article.content,
          "author"=>Article.author,
          "publish_date"=>article_date,
          "created_at"=>Article.created_at.strftime("%F")
        }]
        expect(response_json['article']).to eq(expected_response)
    end
  end

  describe 'gives error if user is not a subscriber' do
    let(:article) { create(:article) }

    before do
      get "/api/v1/article/#{article.id}"
    end

    it 'gives error status when visitor tries to view article' do
      expect(response.status).to eq 401
    end

    it 'gives error message' do
      expect(response_json['error']).to eq 'You are not authorized!'
    end
  end
end