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
  validates :long_url, :user_id, presence: true

  belongs_to :submitter,
             primary_key: :id,
             foreign_key: :user_id,
             class_name: :User,
             optional: true 

  def self.random_code 
    return SecureRandom::urlsafe_base64
  end

  def self.create!(user, long_url)
    short_url = ShortenedUrl.random_code
    new_url = ShortenedUrl.new(short_url: short_url, long_url: long_url, user_id: user.id) 
    new_url.save 
  end

end
