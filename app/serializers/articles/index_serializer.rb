class Articles::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author, :publish_date, :created_at, :image

  def publish_date
    "#{object.created_at.strftime("%d").to_i.ordinalize} #{object.created_at.strftime("%B, %Y")}"
  end

  def created_at
    object.created_at.strftime("%F")
  end

  def image
    if Rails.env.test?
      rails_blob_url(object.image)
    else
      object.image.service_url(expires_in: 1.hours, disposition: 'inline')
    end
  end
end
