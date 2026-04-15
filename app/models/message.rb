class Message < ApplicationRecord
  belongs_to :room

  validates :author_name, presence: ture
  validates :content, presence: ture
end
