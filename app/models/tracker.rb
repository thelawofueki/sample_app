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

class Tracker < ActiveRecord::Base
  attr_accessible :carStat, :id, :lat, :longi, :marker_count, :latlong, :radii, :user_index
end
