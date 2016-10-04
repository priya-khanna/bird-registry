class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: String
  field :visible, type: Mongoid::Boolean, default: false

  validates :name, uniqueness: { scope: :family }, presence: true
  validates :family, presence: true
  validates :added, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be a valid date in format yyyy-dd-mm" }, presence: true
  validates :visible, presence: true
  validate :validate_continents

  private

  def validate_continents
    if self.continents.kind_of?(Array)
      types = self.continents.map(&:class).uniq
      return true if types.count == 1 && types.first == String && continents.count == continents.uniq.count
    end
    self.errors.add(:base, "Continents should be array of unique string values")
    false
  end

end
