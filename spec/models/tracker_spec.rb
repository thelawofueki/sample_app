# == Schema Information
#
# Table name: trackers
#
#  id           :integer          not null, primary key
#  longi        :string(255)
#  lat          :string(255)
#  carStat      :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  marker_count :integer          default(0)
#  latlong      :text(255)
#  radii        :text(255)
#  user_index   :integer
#  contacs      :string(255)
#

require 'spec_helper'

describe Tracker do
  pending "add some examples to (or delete) #{__FILE__}"
end
