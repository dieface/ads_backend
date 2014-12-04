# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  ad_id      :integer
#  image      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
