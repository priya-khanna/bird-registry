require 'rails_helper'

RSpec.describe Bird, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :family }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:family) }
  it { is_expected.to validate_presence_of :added }
  it { is_expected.to validate_presence_of :visible }
  it { is_expected.to validate_format_of(:added).to_allow("2016-01-01").not_to_allow("01-01-01") }

  describe "#bird" do
    let(:bird) { Bird.create({name: "test"}) }
    it "create should validate required fields" do
      expect(bird.errors.full_messages.to_sentence).to eq("Family can't be blank, Added should be a valid date in format yyyy-dd-mm, Added can't be blank, and Continents should be array of unique string values")
    end
  end
end
