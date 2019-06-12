class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.string :location
      t.date :event_date

      t.timestamps
    end
  end
end
