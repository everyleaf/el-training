# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


TASKS = %w[掃除 洗濯 買い物 読書 勉強 散歩 ジム 食事]

(1..3).to_a.each do |num|
  TASKS.each do |task|
    p "Creating task #{task + num.to_s} ..."
    Task.create(name: task + '  ' + num.to_s, status: rand(0..2), due_date: Time.zone.now + 1)
  end
end