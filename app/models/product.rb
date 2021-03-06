class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  has_many :reviews
  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true, numericality: {greater_than_or_equal:  0}
  validates :category, presence: true

end
