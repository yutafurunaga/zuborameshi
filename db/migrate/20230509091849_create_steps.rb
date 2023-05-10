class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.integer :recipe_id
      t.text :instruction
      t.timestamps
    end
  end
end
