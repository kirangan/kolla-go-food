class Food < ApplicationRecord
  belongs_to :category
  belongs_to :restaurant, counter_cache: true
  has_many :line_items
  has_many :reviews, as: :reviewable
  has_and_belongs_to_many :tags

  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true
  validates :image_url, allow_blank: true, format: { 
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG, or PNG image.' 
  }
  validates_associated :category, :restaurant

  before_destroy :ensure_not_referenced_by_any_line_item

  

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  # def self.search(term)
  #   if term
  #     where('name Like ?', "%#{term}%").order('id DESC')
  #   else
  #     order('id DESC')
  #   end
  # end

  private
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line Items present')
        throw :abort
      end
    end
end
