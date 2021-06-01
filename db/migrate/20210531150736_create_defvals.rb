class CreateDefvals < ActiveRecord::Migration[6.0]
  def change
    create_table :defvals do |t|

      t.timestamps
    end
  end
end
