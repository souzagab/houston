# == Schema Information
#
# Table name: agencies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Agency < ApplicationRecord
  validates :name, presence: true
end
