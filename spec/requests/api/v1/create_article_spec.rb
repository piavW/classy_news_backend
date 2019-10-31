RSpec.describe 'POST articles create ' do
  describe 'Journalist can post article successfully' do 
    let(:journalist) { create(:user, role: 'journalist')}
    let(:credentials) { journalist.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      post '/api/v1/articles', 
      params: {
        title: 'New apple-stuff on the way',
        content: 'A lot of new features are being introduced',
        author: 'Author',
        image: {
          type: 'application/jpg',
          encoder: 'name=new_iphone.jpg;base64',
          data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
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

  describe "Regular user can NOT post article" do 
    let(:just_a_user) { create(:user, role: 'subscriber')}
    let(:credentials) { just_a_user.create_new_auth_token}
    let(:headers) {{ HTTP_ACCEPT: "application/json" }.merge!(credentials)}

    before do
      post '/api/v1/articles', 
      params: {
        title: 'New apple-stuff on the way',
        content: 'A lot of new features are being introduced',
        author: 'Author',
        image: {
          type: 'application/jpg',
          encoder: 'name=new_iphone.jpg;base64',
          data: 'iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm',
          extension: 'jpg'
        }
      },
      headers: headers
    end
 
    it 'returns a 401 response' do
      expect(response.status).to eq 401
    end
  end
end