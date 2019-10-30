class Article < ApplicationRecord
  validates_presence_of :title, :content, :author
  has_one_attached :image
  belongs_to :journalist, class_name: 'User'
end
