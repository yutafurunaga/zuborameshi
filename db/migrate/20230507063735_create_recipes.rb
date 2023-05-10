class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :ingredient_id
      t.integer :customer_id
      t.string :dish_name
      t.string :recipe_description
      t.timestamps
    end
  end
end
