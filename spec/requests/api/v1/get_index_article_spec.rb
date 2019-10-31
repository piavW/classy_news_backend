RSpec.describe 'GET articles index' do
  describe 'lists a collection of articles' do
    let(:journalist) { create(:user, role: 'journalist')}
    let!(:article_1) { create(:article, journalist: journalist) }
    let!(:article_2) { create(:article, journalist: journalist) }

    before do
      get '/api/v1/articles'
    end

    it 'returns 2 articles' do 
      expect(response_json['articles'].count).to eq 2
    end

    it "returns data in the correct structure" do
      first_article_date = "#{Article.first.created_at.strftime("%d").to_i.ordinalize} #{Article.first.created_at.strftime("%B, %Y")}"
      second_article_date = "#{Article.last.created_at.strftime("%d").to_i.ordinalize} #{Article.first.created_at.strftime("%B, %Y")}"

      expected_response = [
        {
          "id"=>Article.first.id,
          "title"=>Article.first.title,
          "content"=>Article.first.content,
          "author"=>Article.first.author,
          "publish_date"=>first_article_date,
          "created_at"=>Article.first.created_at.strftime("%F")
        },
        {
          "id"=>Article.last.id,
          "title"=>Article.last.title,
          "content"=>Article.last.content,
          "author"=>Article.last.author,
          "publish_date"=>second_article_date,
          "created_at"=>Article.last.created_at.strftime("%F")
        }
      ]

      expect(response_json['articles']).to eq expected_response
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
      expect(response_json["error_message"]).to eq "There are no articles available"
    end
  end
end