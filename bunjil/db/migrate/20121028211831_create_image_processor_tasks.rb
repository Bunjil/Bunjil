class CreateImageProcessorTasks < ActiveRecord::Migration
  def change
    create_table :image_processor_tasks do |t|
      t.integer :area_update_id
      t.text :red
      t.text :near_infrared

      t.timestamps
    end
  end
end
