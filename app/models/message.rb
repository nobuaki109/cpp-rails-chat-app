class Message < ApplicationRecord
  belongs_to :room

  validates :author_name, presence: true
  validates :content, presence: true
end
