class CreateOpenings < ActiveRecord::Migration[6.0]
  def change
    create_table :openings do |t|
      t.string :i18n_name
      t.string :session_name
      t.string :first_moves

      t.timestamps
    end
  end
end
