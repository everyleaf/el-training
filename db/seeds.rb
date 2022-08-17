# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(name: 'user_0',
                   email: 'user_0@example.com',
                   password: 'password',
                   password_confirmation: 'password')
Category.create(name: Category::DEFAULT_CREATED_CATEGORY, user:)
