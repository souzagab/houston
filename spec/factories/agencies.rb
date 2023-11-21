# == Schema Information
#
# Table name: agencies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :agency do
    name { Faker::Space.agency }
  end
end
