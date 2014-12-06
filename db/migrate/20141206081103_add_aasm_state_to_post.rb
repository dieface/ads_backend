class AddAasmStateToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :aasm_state, :string, :default => "available"
  	add_index :posts, :aasm_state
  end
end
