class CreateGgsnCounters < ActiveRecord::Migration
  def change
    create_table :ggsn_counters do |t|
      t.string :filename
      t.datetime :calltime
      t.integer :records_in
      t.integer :records_out
      t.integer :malformed_data
      t.integer :missing_data
      t.integer :zero_value
      t.integer :min_too_low

      t.timestamps
    end
  end
end
