# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.create!(email: 'admin@admin',password: 'testtest')

tags = ['肉料理', '野菜料理', '魚介料理', '麺類', 'ご飯もの', '汁物', '和食', '洋食', '中華', 'パン類' ] # タグの一覧を定義

tags.each do |tag_name|
  tag = ActsAsTaggableOn::Tag.new
  tag.name = tag_name
  tag.save
end