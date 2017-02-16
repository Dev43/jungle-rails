module ApplicationHelper

  def real_price(price_cents)
    price_cents.to_f / 100
  end

  def total_amount(products)
    total = 0
    products.each do |product|
      total += product.item_price_cents
    end
    real_price(total)
  end

end
