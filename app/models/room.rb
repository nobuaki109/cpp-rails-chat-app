class Room < ApplicationRecord
    has_many :messages, dependent: :destroy

    validates :name, presence: ture
end
