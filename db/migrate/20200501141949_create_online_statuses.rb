class CreateOnlineStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :online_statuses do |t|
      t.references :user, foreign_key: true
      t.boolean :online

      t.timestamps
    end
  end
end
