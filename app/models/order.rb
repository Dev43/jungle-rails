class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_quantity

  attr_accessor :quantity


  private

  def update_quantity
    line_items = self.line_items
    line_items.each { |item| item.product.update_attributes(:quantity => item.product.quantity - item.quantity )}
  end

end
