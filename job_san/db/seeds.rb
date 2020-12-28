# frozen_string_literal: true

User.create(name: Faker::JapaneseMedia::Naruto.character,
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password')
