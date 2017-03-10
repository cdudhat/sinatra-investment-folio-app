# Requirements for the Sinatra Portfolio Project

Requirements:

- [x] Build an MVC Sinatra Application

      *App includes MVC Sinatra methodology*

- [x] Use ActiveRecord with Sinatra

      *ApplicationController inherits from Sinatra::Base*

- [x] Use Multiple Models

      *Application includes five (5) different models: User, Stock, (Bank) Product, Property, Fund*

- [x] Use at least one has_many relationship

      *User `has_many` stocks, (bank) products, propertys and funds. Total of four (4) `has_many` relationships have been used*

- [x] Must have user accounts. The user that created a given piece of content should be the only person who can modify that content

      *App can only be accessed as a user. User must sign-up before first use, and login before any consecutive usage*

- [x] You should validate user input to ensure that bad data isn't created

      *All models have validation requirements to ensure bad data isn't created at generation/modification of any instance of any model*
