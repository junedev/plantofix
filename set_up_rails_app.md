### How to set up a rails app from data model

+ Draw data objects
+ Add relationships
+ Add attributes and data types
+ create rails app and create database (rails new + rake db:create)
+ add additional gems needed to Gemfile, e.g uncomment bcrypt, `gem 'bootstrap-sass', '~> 3.2.0'` and bundle (+ rbenv rehash)
+ generate controllers or scaffolds for data objects (inlcude session with new create and destoy if using bcrypt)
+ set root route to be mainresouce#index
+ add relationship helpers to models and add has_secure_password for user class
+ set up controllers if not scaffolded
+ add `session[:user_id] = @user.id` to user create controller to have user logged in after sign-up
+ add current_user function etc. to application controller (see code)
+ Fix session controller (see code)
+ Delete destroy and create view for session
+ Make a login page html in view session new (see code)
+ Exchange password fields in view user new (see code)
+ Add logout field to e.g. to navigation or layout application (see code)
+ Add validation
+ Input seed data
+ add partials for objects and replace index page with `<%= render @users %>`
+ add partials for navbar, header, footer in application.html.erb
+ exchange application.scss with import commands for bootstrap
+ add bootstrap stuff to application.js
+ do styling


## Add on for application controller
```
helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) 
    else
      false
    end
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    unless logged_in?
      flash[:error] = "You must be logged in to access this page."
      redirect_to login_url
    end
  end

  def authenticate_user(user)
    if user != current_user
      flash[:error] = "You are not authorized to do that."
      redirect_to root_path
    else 
      true
    end
  end

```

## Session controller
```
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You are now logged in!"
    else
      flash.now.alert = "Invalid login credentials."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
```

## Login form
```
<%= form_tag sessions_path do %>
<div class="field">
  <%= label_tag :email %>
  <%= text_field_tag :email %>
</div>
<div class="field">
  <%= label_tag :password %>
  <%= password_field_tag :password %>
</div>
<div class="actions"><%= submit_tag "Log me in" %></div>
<% end %>
```

## User new password fields (sign-up page)
```
<div class="field">
  <%= f.label :password %>
  <%= f.password_field :password %>
</div>
<div class="field">
  <%= f.label :password_confirmation, "Repeat password" %>
  <%= f.password_field :password_confirmation %>
</div>
```

## Logout Link
```
<% if current_user %>
  <li><%= link_to "Add a flower", new_photo_path %></li>
  <li><%= link_to "My profile", user_path(current_user()) %></li>
  <li><%= link_to "My flowers", my_photos_path %></li>
  <li><%= link_to "Logout", logout_path, method: :delete, data: {confirm: "Are you sure?"} %></li>
<% end %>
```
