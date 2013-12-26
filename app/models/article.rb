class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validate title: presence
  validate text: presence
end
