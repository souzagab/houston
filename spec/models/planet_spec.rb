# == Schema Information
#
# Table name: planets
#
#  id                                                            :bigint           not null, primary key
#  distance_to_earth(Distance in megameters (1mm = 1,000,000km)) :integer          not null
#  name                                                          :string           not null
#  created_at                                                    :datetime         not null
#  updated_at                                                    :datetime         not null
#
RSpec.describe Planet do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:distance_to_earth) }
    it { is_expected.to validate_numericality_of(:distance_to_earth).is_greater_than_or_equal_to(Planet::CLOSEST_DISTANCE_TO_EARTH) }
  end
end
