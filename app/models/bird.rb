class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :added, type: String
  field :visible, type: Mongoid::Boolean

  validates :name, uniqueness: { scope: :family }, presence: true
  validates :family, presence: true
  validates :added, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be a valid date in format yyyy-dd-mm" }, presence: true
  validate :validate_continents

  private

  def validate_continents
    if self.continents.kind_of?(Array)
      types = self.continents.map(&:class).uniq
      return true if types.count == 1 && types.first == String
    end
    self.errors.add(:base, "Invalid continent values")
    false
  end

end
