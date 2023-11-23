# == Schema Information
#
# Table name: payloads
#
#  id                                    :bigint           not null, primary key
#  cargo                                 :enum             not null
#  description                           :text             default(""), not null
#  name                                  :string           not null
#  spacecraft_type                       :string           not null
#  weight(Cargo weight in Tons (1000kg)) :integer          not null
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  spacecraft_id                         :bigint           not null
#
# Indexes
#
#  index_payloads_on_cargo       (cargo)
#  index_payloads_on_spacecraft  (spacecraft_type,spacecraft_id)
#
RSpec.describe Payload do
  describe "associations" do
    it { is_expected.to belong_to(:spacecraft).inverse_of(:payloads) }
  end

  describe "attributes" do
    it { is_expected.to define_enum_for(:cargo).backed_by_column_of_type(:enum).with_values(described_class.cargos) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
  end
end
