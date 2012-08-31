class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.decimal :longitude
      t.decimal :latitude
      t.text :description

      t.timestamps
    end
  end
end
