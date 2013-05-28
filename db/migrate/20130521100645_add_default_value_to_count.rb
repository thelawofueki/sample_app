class AddDefaultValueToCount < ActiveRecord::Migration
  def change
  	change_column :trackers, :marker_count, :int, :default => 0
  end
end
