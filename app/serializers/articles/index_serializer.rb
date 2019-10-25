class Articles::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author, :publish_date, :created_at

  def publish_date
    "#{object.created_at.strftime("%d").to_i.ordinalize} #{object.created_at.strftime("%B, %Y")}"
  end

  def created_at
    object.created_at.strftime("%F")
  end
end
