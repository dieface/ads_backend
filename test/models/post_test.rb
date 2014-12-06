# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  genre      :string(255)
#  content    :text
#  lat        :float
#  lng        :float
#  address    :string(255)
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  aasm_state :string(255)      default("available")
#

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
