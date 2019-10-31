describe ArticlePolicy do
  subject { described_class.new(user, article) }
  let(:article) { create(:article) }

  context 'user is a subscriber' do
    let(:user) { nil }
    it { is_expected.to permit_actions [:show, :index] }
  end

  context 'user is a subscriber' do
    let(:user) { create(:user) }
    it { is_expected.to forbid_new_and_create_actions }
  end

  context 'user of role subscriber cannot edit or update an article' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_edit_and_update_actions }
  end
end

describe ArticlePolicy do
  subject { described_class.new(user, article) }
  let(:user) { User.create(role: 'journalist') }
  let(:article) { Article.create }

  context 'user is a journalist' do
    it { is_expected.to permit_new_and_create_actions }
  end

  context 'journalist can edit & create an article' do
    it {is_expected.to permit_actions(%i[show index create edit]) }
  end
end