# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  juhe_id      :string
#  province     :string
#  city         :string
#  district     :string
#  current_temp :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class City < ApplicationRecord
end
