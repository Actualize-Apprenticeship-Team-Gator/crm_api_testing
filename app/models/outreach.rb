class Outreach < ApplicationRecord
  belongs_to :lead

  validates :text, presence: true
end
