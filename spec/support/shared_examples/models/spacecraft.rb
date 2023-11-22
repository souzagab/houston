# == Schema Information
#
# Table name: spacecrafts
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  speed(Speed in km/h) :float            not null
#  type                 :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  agency_id            :bigint           not null
#
# Indexes
#
#  index_spacecrafts_on_agency_id  (agency_id)
#  index_spacecrafts_on_type       (type)
#
# Foreign Keys
#
#  fk_rails_...  (agency_id => agencies.id)
#
RSpec.shared_examples Spacecraft do |spacecraft|

  it { is_expected.to be_a(Spacecraft) }

  context "associations" do
    it { is_expected.to belong_to(:agency) }
  end

  context "validations" do
    subject { build(spacecraft) }

    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:speed) }
    it { is_expected.to validate_presence_of(:remaining_fuel) }
  end

  describe "factories" do
    it "builds properly" do
      expect(build(spacecraft)).to be_valid
    end

    it "creates properly" do
      expect { create(spacecraft) }.not_to raise_error
    end
  end
end
