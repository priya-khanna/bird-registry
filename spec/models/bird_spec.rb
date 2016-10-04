require "spec_helper"

describe 'bird' do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :family }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:family) }
  it { is_expected.to validate_presence_of :added }
  it { is_expected.to validate_presence_of :visiible }
  it { should allow_value("2016-01-01").for(:added) }
  it { should_not allow_value("01-01-01").for(:added) }
  it { should allow_value(["abc", "def"]).for(:continents) }
  it { should_not allow_value([1, "def"]).for(:continents) }
end



