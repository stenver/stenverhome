class Article < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true
  validates :text, presence: true
end
