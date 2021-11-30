# Rails Training

## About this curriculum

This document is for those who needs fundamental trainings like Ruby on Rails and related technologies.
Regardless of your skills, you must take every lecture we offer.
Our training program period is unspecified.
Once you have finished a series of steps, the training programs will be completed.

The roles for this curriculum should be below.

- NewComer(Mentee): Attendee of this program
- Mentor: Trainer
  - As for reviews for programs they make, we recommend team to share it in order to reduce workloads of their mentor.

It is up to the mentor to decide how much the mentor is involved in teaching. In addition, regarding the training period, the mentor will set a guideline in advance, taking into consideration the skill level of new employees and the status of ongoing  projects.

## License

This curriculum is under [Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en)

[![creative commons license](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en)

## Overview

### System requirements

In this curriculum, you have to develop "task management system" as an assignment.
the requirement should be like this.

- Want to post your tasks easily
- Want to set an expiration date for a task
- Want to prioritize tasks
- Want to manage the status (not started / started / completed)
- Want to narrow down tasks by status
- Want to search for a task by task name / task description
- Want to list the tasks. I want to sort on the list screen (based on priority, expiration date, etc.)
- Want to label tasks and classify them
- Want to register as a user so that I can see only the tasks I registered
- Want to be able to carry out maintenance

We also want the following management functions to meet the above requirements.

- User Admin Tool

** *However, the mentor may ask you to skip the implementation of a specific function **
  **Please implement the steps marked with "★" under the direction of the mentor.**

**(Mentors should decide whether to skip based on the development experience of the mentee and the quality of implementation of each step)**


### Support browser

- Support browser is suppose to be the latest version of macOS / Chrome

### About Application server arrangement

I would like you to build using the following languages and middleware (both are the latest stable versions).

- Ruby
- Ruby on Rails
- MySQL

**Performance requirements and security requirements are not specified, but please make with general quality. If the site you made is too slow, we would ask you to fix it.**

## The ultimate goal of this curriculum

At the end of this curriculum, you'll be able to reach following levels.

- Being able to implement basic web applications using Rails
- Being able to publish your application in a Rails application using a common environment
- Being able to add features and maintain data for developed Rails applications
- Learn the flow of PR and merging on GitHub. Also, learn the Git commands required for it.
  - Being able to commit with proper commit size
  - Being able to write a proper PR description
  - Being able to respond to reviews and fix errors
- Being able to ask questions to team members and related parties (this time I will be a mentor) verbally or chat at the right time

## Assignment steps

### Step 0: Let's install chrome-extension

Actually, this training was based on the one made by Manyo Co., Ltd., and there were several cases where past trainee mistakenly made a PR to the original repository. To avoid repeating this tragedy, install a chrome-extension that automatically redirects pages

#### 1-1: Clone chrome-extension

`git clone git@github.com:Fablic/fablic-chrome-extension.git`

#### 1-2: Install chrome-extension

Open chrome: // extensions /, turn on Developer mode in the upper right, and install RKGithubSupportTool by dragging and dropping.

#### 1-3: Start training while thanking Manyo Co., Ltd.

[Original repository](https://github.com/everyleaf/el-training)

### Step 1: Build a Rails development environment

#### 1-1: Ruby installation

- Please use [rbenv](https://github.com/rbenv/rbenv) to install the latest version of Ruby
  - `gem install bundler`を実行して下記のようなエラーが出るときは、System Prefernces → network 
  　 `ERROR:  Could not find a valid gem 'bundler' (>= 0), here is why:Unable to download data from https://rubygems.org/ - timed out (https://api.rubygems.org/specs.4.8.gz)`
  - If you get the following error after executing `gem install bundler` , change the ipv6 setting of System Prefernces -> network -> Advanced -> TCP / IP to link-local only.
  　 `ERROR:  Could not find a valid gem 'bundler' (>= 0), here is why:Unable to download data from https://rubygems.org/ - timed out (https://api.rubygems.org/specs.4.8.gz)`
- Make sure the command `ruby -v` shows the Ruby version

#### 1-2: Rails installation

- Install Rails with Gem command
- Please install the latest version of Rails
- Make sure the command `rails -v` shows the Rails version

#### 1-3: Database (MySQL) installation

- Install MySQL on your OS
  -For macOS, use `brew` for installation

### Step 2: Create a repository on GitHub

- Install git on your local env
  - If your PC is macOS, use `brew` or something
  - Submit your username and mailaddress by using `gitconfig`
- Let's think about your app name
- Let's create new branch
  - Create new branch with same branch name as your account name based on master branch
    - `git checkout -b github_account_name origin/master`
  - Let's push your branch to remote

### Step 3: Let's create a Rails project

- Create files and directories by using `rails new`
- Create docs` directory on your current application and make this document on that directory
  - This is to keep the specifications of this app under control so that they can be viewed at any time.
- Push your app to the branch you created on GitHub
- In order to specify the version, let's describe on Gemfile the version of Ruby to use in (Make sure that Rails already has the version)

### Step 4: Think about the image of the application you want to create

- Before proceeding with the design, let's think about the completed image (with the mentor) of what the app will look like. Screen design by paper prototyping is recommended
- Read the system requirements and think about the data structure you need
  - What kind of model (table) seems to be needed
  - What kind of information is needed in the table
- After considering the data structure, let's write it by hand on the model diagram.
  -	Take a picture when you're done and put it in the repository
  - Describe the table schema in `README.md` (model name, column name, data type)
* At this moment, it is not necessary to create the correct model diagram. Let's make it as a brief concept at the moment (You'll be able to make some amendment it if you think it is wrong in the future steps)

### Step 5: Let's set the database connection settings (peripheral settings)

- First, let's make a new topic branch with Git
  - After that, you will work on the topic branch and commit
- Install Bundler
- Let's add `mysql2` in your `Gemfile` (MySQL database driver)
- Configure `database.yml`
- Create database with `rails db:create`
- Check a database connection with `rails db`
- Create PR (Pull Request) on GitHub and let them review your source program
  - If you get some review comment on your PR, let's deal with it. You'll need 2 LGTM (Looks Good To Me) before you merge onto master

### Step 6: Let's create a task model

Create CRUD to manage the tasks. First of all, let's make it with a simple structure where only the name and details can be registered.

- Create task model for CRUD with `rails generate`
- Use migration and create tables
  - It is important to ensure that the migration can be returned to the previous state! Let's get into the habit of checking by using `redo`
- Make sure you can connect to the database via the model with the command `rails c`
  - Try creating a record with ActiveRecord
- Create a PR on GitHub for review

### Step 7: Let's do register / update / delete tasks

- Let's create a task list feature, creation feature, detail feature, edit feature
  - Create controller and view with command `rails generate`
  - Let's add the required implementation to the controller and view
  - Let's display a flash message on the screen after creating, updating, and deleting
- Let's edit `routes.rb` to display the task list with `http://localhost:3000/`
- Create a PR on GitHub for review
  - In the future, if the PR is likely to grow, consider dividing the PR into two or more times.

### Step 8: Write a test (system spec)

- Get ready to write a spec
  - Let's get prepared  `spec/spec_helper.rb`, `spec/rails_helper.rb`
- Let's write a system spec for the task function
  - Rails 5.1 以降、新たにsystem testの機能を追加しました
  - After Rails 5.1, we have added a new system test function
    - [日本語](https://qiita.com/jnchito/items/c7e6e7abf83598a6516d), [English](https://rossta.net/blog/why-rails-system-tests-matter.html)
  - After changing system spec, you don't need `database_cleaner` for feature spec.
- Introducing CI(Continuous Integration) like Circle CI, let's ping Slack
  - Introducing CI is optional when PRing in Fablic/training. There's no execution permission because of no admin permission.
- cf. https://leanpub.com/everydayrailsrspec/

### Step 9: Make various settings for the app

- Commonalize Japanese part(message and labels etc...)
  - Use Rails i18n for doing the task
  - After configure these tasks, you'll get more benefit from messaging
- Set the time zone
  - Fix your time zone to Tokyo/Japan on Rails
- Configure error page
  - Replace your customized error page from default
  - Set the error page appropriately according to the situation
  - Two types of status code settings, page 404 and page 500, are required at least

### Step 10: Sort the task list in order of creation date and time (Optional)

- Currently, they are sorted in order of ID, but let's sort them in descending order of creation date and time.
- Let's write in the system spec that the sorting is working well

### Step 11: Let's set the validation

- Let's set the validation
  - Think about which validation to add to which column
  - Let's create a migration that also sets DB constraints
  - Create with a `rails generate` command to create only the migration file
- Let's display a validation error message on the screen
- Let's write a model test for validation
- Create a PR on GitHub for review

### Step 12: Add due date of the task (Optional)

- Make it possible to register a due date for the task
- Implement a functionality to sort the task by due date on the list screen
- write a test function for this functionality
- After finishing PR, let's release it

### Step 13: Add status to make it searchable

- Let's add status (not started / started / completed)
  - [Optional requirements] If you are not a beginner, you may install a Gem that manages the state.
- Let's make it possible to search by title and status on the list screen
  - [Optional requirements] If you are not a beginner, you may install a gem that makes it convenient to implement search such as ransack.
- When narrowing down on searching, let's check the changes in the issued SQL by looking into the log
  - Get in the habit of checking up logs as needed in the following steps
- Let's add on the search index on the table
- Let's add a model spec to the search (let's expand the system spec as well)

### Step 14: Let's add pagination

- Let's add pagination to the list view using a gem called Kaminari

### Step 15: Apply your design(Optional)

- Introduce Bootstrap and apply your design to the apps you've created so far
  - [Optional requirements] Write and design your own CSS

### Step 16: Make it available to multiple people (introduction of user feature)

- Let's create a user model
- Let's create the first user with seed
- Let's connect users and tasks
  - Index for associations
  - Incorporate a mechanism to avoid the N + 1 problem


### Step 17: Let's implement login / logout function

- Let's implement it ourselves without using additional gems
  - By not using Gem such as Devise, the purpose is to deepen the understanding of the mechanism such as HTTP cookies and Session in Rails.
  - It also aims to deepen your understanding of general authentication (such as password handling).
- Let's implement a login screen
- If you are not logged in, let's prevent you from transitioning to the task management page
- Display the tasks only you created
- Let's implement the logout function

### Step 18: Let's implement the user management screen(Optional)

- Let's add a management menu on the screen
  - Make sure to put the URL `/admin` at the beginning of the admin tool .
- Before adding the url to `routes.rb`, let's design by assuming the URL and routing name (name to be `*_path`) in advance
- Let's implement user list / create / update / delete
- After deleting a user, try deleting the tasks that the user has.
- Let's display the number of tasks that the user has on the user list view
- Let's see the list of user-created tasks

### Step 19: Add a role to the user(Optional)

- Let's make users distinguish between administrative users and general users
- Let's make only the admin user access the user admin tool
- Let's make it possible to select a role on the user management tool
- Let's control the deletion so that no administrative user is gone
- * You can use Gem freely.

### Step 20: Let's be able to put labels on tasks

- Let's allow tasks to have multiple labels
- Let's make it possible to search by the attached label

### Step 21: Let's create a maintenance function

- Let's create a batch to start / end maintenance
- Redirect users who access during maintenance to the maintenance page
- Let's implement it ourselves without using additional gems

## Afterword

Thank you for your hard work. You have completed the educational curriculum !!

Now that we have created one application, let's announce it at mikitani night (in-house LT meeting). I think it will be a good opportunity to make a presentation.

I couldn't cover it in this curriculum, but I think that the following topics will be needed in the future, so I think it's a good idea to proceed with learning (I think that you will often learn through projects).

- Deepen your basic understanding of web applications
   - Understanding HTTP and HTTPS
- Learn a little more advanced use of Rails
   - Logging
   - Explicit transaction
   - Asynchronous processing
   - Asset pipeline
- A more advanced understanding of frontends such as JavaScript and CSS
- Deepen your understanding of the database
   - SQL
   - Build more performance-focused queries
   - Deepen your understanding of the index
- A better understanding of the server environment
   - Linux OS
   - Web server (Nginx) settings
   - Application server (Unicorn) settings
   - Understanding the settings for MySQL
- Understanding tools for releases
   - Capistrano
   - Ansible

## (Extra edition) Optional requirements

Apart from the required requirements, the optional requirements for the task management system are listed below. Please consult with your mentor and carry out as necessary.

### Optional Requirement 1: Want to be alerted if there is a task that is nearing completion or overdue

- When you log in, let's display tasks that are nearing completion or have expired somewhere.
- It is better if you can display the read/unread tasks

### Option Requirement 2: Want to be able to share tasks among users

- Want to allow multiple people to view and edit the same task
  - Example: Being able to share tasks with mentors and mentees
- Show task creator

### Option Requirement 3: Want to be able to set groups

- Continuation of option requirement 2
- Want to be able to set a group so that tasks can be referenced only within the group


### Option Requirement 4: Want to be able to attach attachments to tasks

- Let's make it possible to attach attachments to tasks
- For Heroku, manage attachments uploaded to your S3 bucket
- Let's use Gem appropriately

### Optional Requirement 5: Let's allow users to set a profile picture

- Let users be able to set their profile picture
- The uploaded image will be used as an icon, so you make a thumbnail image so that it will not be delayed.
- Select gems and libraries appropriately

### Optional Requirement 6: Want task calendar functionality

- Let's try to display tasks by expiration date in the calendar to visualize the expiration date
- You are free to use or not use the library

### Option Requirement 7: Want to be able to sort tasks by drag and drop

- Let's drag and drop tasks in the task list so that they can be sorted

### Optional Requirement 8: Let's depict a graph how often labels are used

- Let's introduce a graph to visualize statistical information
- Let's propose a graph type that is easy to see

### Optional Requirement 9: Create a task that is about to finish and email the user

- If you have a task that is about to finish, let's notify you by email in the background
- Use cloud service to send emails
  - SendGrid for Heroku
  - For AWS, Amazon SES etc.
- Let's send emails in batch once a day
  - Heroku is Heroku Scheduler (add-on)
  - If it is AWS, try setting cron

### Option Requirement 10: Launch an instance on AWS and build an environment

- Let's build the environment on AWS and deploy it
- Nginx + Unicorn is recommended for middleware
- Please refer to the server requirements for EC2 instances etc.

### Option Requirement 11: Let's get labels by Ajax

- Continuation of step 20
- Let's make it hidden (label data not acquired) when the label is initially displayed when registering a task.
- Instead, prepare a button for adding a label, etc., and try to acquire and display the label data by pressing that button.
- Let's write a test code
