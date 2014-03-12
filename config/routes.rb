Stack::Application.routes.draw do

  # active admin added it's own URLs to the site
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)



	# now i want to set up all of the urls for the stories controller
	# this is a shortcut for adding SEVEN different actions

	# REST is a way to alter and view data, the 7 actions are...
	# index, show, new, create, edit, update, destroy

	resources :stories do # this basically says enable the above 7 actions for the stories controller
		# inside stories we have a nested resource which is a relationship between stories and comments. Because comments is within
		# the stories it's saying that they are connected and dependent on the stories

		resources :comments

		resources :votes 
		

	end	

	# resources :stories creates seven different routes in the application, all mapping to the Stories controller. Each action corresponds to a
	# a URL/path and a page with the same name in the case of Index, Show, New and Edit. The other actions Create, Update, Destroy don't typically 
	# render pages and main purpose is to modify the database.

	# HTTP VERB		PATH/URL				ACTION			USED FOR
	# GET			/stories			index			display a list of all stories
	# GET			/stories/new		new				return an HTML form for creating a new story
	# POST			/stories			create			create a new story
	# GET			/stories/:id		show			display a specific story
	# GET			/stories/:id/edit	edit			return an HTML form for editing a story
	# PUT			/stories/:id		update			update a specific story
	# DELETE		/stories/:id		destroy			delete a specific story

	# Creating a resourceful route also exposes a number of helpers to the controllers in your application. As below:

	# new_story_path returns /stories/new same as stories#new
	# edit_story_path returns /stories/:id/edit same as stories#edit
	# story_path returns /stories/:id (the show page) same as stories#show
	# stories_path returns /stories (the index page) same as stories#index

	# the nested resources:comments generates 

		# new_story_comment_path returns /stories/:story_id/comments/new  --> comments#new
		# edit_story_comment_path returns /stories/:story_id/comments/:id/edit --> comments#id
		# story_comment_path returns /stories/:story_id/comments/:id      --> comments#show
		# story_comments_path returns /stories/:story_id/comments    --> comments#index

	# to see all of the URLs across the site cancel out of rails server and type rake routes in terminal	
  
  	# now set up my homepage to go to the stories controller
  	# and show the index page

  	root "stories#index"

  	# root_path

end
