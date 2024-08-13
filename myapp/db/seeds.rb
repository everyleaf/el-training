# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Task.create(title: "title 1", description: "desc 1")
Task.create(title: "title 2", description: "desc 2")
Task.create(title: "title 3", description: "desc 3")
Task.find(3).update(title: "title 3.1", description: "desc 3.1")