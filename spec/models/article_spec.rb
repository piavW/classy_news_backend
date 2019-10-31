require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :id }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :content }
    it { is_expected.to have_db_column :author }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content } 
    it { is_expected.to validate_presence_of :author } 
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect( create(:article)).to be_valid 
    end
  end
  
  it 'Should have a journalist' do
    should belong_to(:journalist)
  end
end