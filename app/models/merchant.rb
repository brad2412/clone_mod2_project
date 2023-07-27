class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items

  def self.enabled
    where(enabled: true)
  end

  def self.disabled
    where(enabled: false)
  end
end