# == Schema Information
#
# Table name: missions
#
#  id                         :bigint           not null, primary key
#  description                :text             default(""), not null
#  duration(Duration in days) :integer          not null
#  spacecraft_type            :string           not null
#  start_date                 :datetime         not null
#  status                     :enum             default("scheduled"), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  planet_id                  :bigint           not null
#  spacecraft_id              :bigint           not null
#
# Indexes
#
#  index_missions_on_planet_id   (planet_id)
#  index_missions_on_spacecraft  (spacecraft_type,spacecraft_id)
#  index_missions_on_status      (status)
#
# Foreign Keys
#
#  fk_rails_...  (planet_id => planets.id)
#
RSpec.describe Mission, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:planet) }
    it { is_expected.to belong_to(:spacecraft) }
  end

  describe "attributes" do
    it { is_expected.to define_enum_for(:status).backed_by_column_of_type(:enum).with_values(described_class.statuses) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
