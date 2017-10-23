# README

How To Build Go-Food Application with Ruby on Rails

I using Ubuntu 14.04(Trusty).

- Install Ruby, in this tutorial we use rvm to install, https://rvm.io/
	- $gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	- $\curl -sSL https://get.rvm.io | bash -s stable
	- $rvm install 2.4.2

- Install Rails,
	- $gem install rails(in this tutorial 5.1.4 version)

- Install PostgreSQL 9.6, https://www.postgresql.org/download/linux/ubuntu/
	- Create the file /etc/apt/sources.list.d/pgdg.list, and add a line for the repository 
		deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
	- Import the repository signing key, and update the package lists 
		$wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  		sudo apt-key add - sudo apt-get update 
	- write in your terminal
		$apt-get install postgresql-9.6 

- Now, make Rails app
	- $rails new go-food

- You can look your application in localhost by
	- $rails server
	- open your browser, http://localhost:3000/
	(for some version of linux, you'll find error, so open your Gemfile, uncomment gem 'therubyracer', platforms: :ruby, then type 'bundle' in console)
	- your application is running!!

- Now, make a new controller with Home name, and hello action
	- $rails generate controller Home hello

- Open app/controllers/home_controller.rb
  There will be method hello, rails already made it when we generate, so we add instance variable
	- @time = Date.today

- Open app/views/home/hello.html.erb
  Rails also already write some html text, delete it, we will use a new text
  	<h1>Hello from Go-Food!</h1>
	<p>
  	It is now <%= @time %>
	</p>

- Show in your browser with write in console, rails server or rails s, open in localhost:3000/hello. And you can see your new interface.

- Next step is make a user table, write
	- $rails g model user (we can simplify write 'g' instead of 'generate')

- Then make migrate, 
	- $rails db:create (for the first time, because we have not a database yet), then
	- $rails db:migrate

- Open app/db/migrate, there will be a new file, timestamp_create_users, open it
	- Add some instance variables, username and full_name, above t.timestamp
		t.string :username, null: false
    	t.string :full_name

- Then we can check it in Rails console by,
	- $rails c

- Try with some methods rails console, such as
	- User.find(1) (for search the first user)
	- User.where(username: "steve") (for search data with username steve)
	and of course we don't get anything, because we don't have data yet.

- For make table data,
	- User.create(username: 'steve', full_name: 'Steve Jobs') then you can try instruction previously

- Now, let't make user data appear in browser, firstly edit home_controller.rb. Add instance variable users below time
	- @users = User.all

- Then edit hello.html.erb
	<p>
	List of user: 
	</p>
	<ul>
		<% @users.each do |user| %>
		<li><%= user.username%> - <%= user.full_name %></li>
		<% end %>
	</ul>

- Save it, write rails server, and open http://localhost:3000/home/hello
