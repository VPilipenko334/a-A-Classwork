# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :short_url, uniqueness: true
  validates :long_url, :user_id, presense: true

  belongs_to :user,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: :User
end
