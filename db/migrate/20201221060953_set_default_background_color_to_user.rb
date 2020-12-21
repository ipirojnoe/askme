class SetDefaultBackgroundColorToUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :background_color, :string, default: "#005a55"
  end
end
