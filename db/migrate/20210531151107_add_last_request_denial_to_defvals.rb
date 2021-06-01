class AddLastRequestDenialToDefvals < ActiveRecord::Migration[6.0]
  def change
    add_column :defvals, :last_request_denial, :bigint
  end
end
