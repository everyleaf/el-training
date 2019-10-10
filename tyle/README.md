# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Step 4
### Database Schema

![ER](https://user-images.githubusercontent.com/56104871/66540876-40ee5c80-eb68-11e9-936f-f72c251135e4.JPG)


user
|name        |type    |
|------------|--------|
|id(PK)      |int     |
|name        |varchar |
|deleted     |datetime|


auth_information
|name           |type    |
|---------------|--------|
|user_id(PK&FK) |int     |
|login_id       |varchar |
|password       |varchar |


task
|name        |type    |
|------------|--------|
|id(PK)      |int     |
|name        |varchar |
|description |text    |
|user_id(FK) |int     |
|priority    |varchar |
|status      |varchar |
|due         |datetime|


intermediate table
|name            |type   |
|----------------|-------|
|task_id(PK&FK)  |int    |
|label_id(PK&FK) |int    |
|id              |int    |


label
|name         |type   |
|-------------|-------|
|id(PK)       |int    |
|name         |varchar|
