class AddIndexGgsnCountersCalldate < ActiveRecord::Migration
  def up
    add_index :ggsn_counters, :calltime
  end

  def down
    remove_index :ggsn_counters, :calltime
  end
end
