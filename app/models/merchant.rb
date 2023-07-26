class Merchant < ApplicationRecord
<<<<<<< HEAD
  validates :name, presence: true

=======
>>>>>>> 2c295ea0059190440a955e5b2a0039d7f08ca500
  has_many :items
end