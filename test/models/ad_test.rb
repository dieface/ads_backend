# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  scale       :string(255)
#  start_date  :datetime
#  end_date    :datetime
#  lat         :float
#  lng         :float
#  url         :string(255)
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

require 'test_helper'

class AdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
