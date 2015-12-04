class ContestGroup < ActiveRecord::Base
  has_many :contests

  validates :name, presence: true
end
