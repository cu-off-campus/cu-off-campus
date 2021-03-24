class Apartment < ActiveRecord::Base
  def self.filter(query, price_range, ordering)
    t = with_price_range(price_range)
    unless query.nil? || query.empty?
      query = "%#{query.downcase}%"
      t = t.where("(LOWER(address) LIKE ?) OR (LOWER(name) LIKE ?)", query, query)
    end
    t.order(ordering)
  end

  def self.with_price_range(range)
    return all if range.nil?

    l, r = range
    return all if l.nil? && r.nil?

    l = 0 if l.nil?
    return where(price: (l..r)) unless r.nil?

    where("price >= ?", l)
  end

  def rating
    Comment.rating_of id
  end

  def comments
    Comment.where(apartment_id: id).order(updated_at: :desc)
  end

  def num_comments
    comments.count
  end
end
