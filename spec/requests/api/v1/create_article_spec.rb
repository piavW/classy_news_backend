RSpec.describe 'POST articles create ' do
  describe 'User can post article successfully' do 
    let(:headers) {{ HTTP_ACCEPT: "application/json" }}

    before do
      post '/v1/articles', params: {
        title: 'New apple-stuff on the way',
        content: 'A lot of new features are being introduced',
        image: {
          type: 'application/jpg',
          encoder: 'name=new_iphone.jpg;base64',
          data: 'long-string-of-image-data',
          extension: 'jpg'
        }
      },
      headers: headers
    end

    it 'returns a 200 response' do
      expect(response.status).to eq 200
  end

  it 'article has an image attached' do
    article = Article.find_by(title: response.request.params['title'])
    expect(article.image.attached?).to eq true
  end
end

describe 'User can successfully create an article' do
  it 'user can successfully create an article' do
    User.create(article)
    expect(article).to be_valid 
  end
end