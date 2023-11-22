# == Schema Information
#
# Table name: agencies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Agency, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end