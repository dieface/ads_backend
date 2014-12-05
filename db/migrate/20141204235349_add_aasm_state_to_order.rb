class AddAasmStateToOrder < ActiveRecord::Migration
# unavailable
# available
  def change
    add_column :ads, :aasm_state, :string, :default => "unavailable"
    add_index :ads, :aasm_state  	
  end
end
