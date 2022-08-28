# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do |user_idx|
  user = User.create(name: "seed_#{user_idx}",
                     email: "seed_#{user_idx}@example.com",
                     password: 'password',
                     password_confirmation: 'password',
                     activated: true,
                     activated_at: Time.zone.now)
  category = Category.create(name: Category::DEFAULT_CREATED_CATEGORY, user:)
  5.times do |task_idx|
    Task.create(name: "task_#{user_idx}_#{task_idx}",
                category:,
                start_date: Time.zone.now,
                necessary_days: 5,
                progress: 0,
                priority: 0)
  end
end
