class ContestGroup < ActiveRecord::Base
  has_many :contests, dependent: :destroy

  validates :name, presence: true
end
