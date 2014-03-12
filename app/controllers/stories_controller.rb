class StoriesController < ApplicationController

	# this is how to add a page to my site 
	# we will add the index page (aka the homepage)

	def index	
		# in here lives all the code for the index page
		@username = "dave"


		# to make a list we use square brackets. This is an array.
		# @stories = ["Google", "Facebook", "Twitter", "LinkedIn", "Foursquare"]

		# so now we want to get our data from the database i.e from the model called Story. The capitalised Story refers to the model/database

		# @stories = Story.all --> '.all' means to retrieve all fields 

		# @stories = Story.order("votes_count desc, created_at desc") 

		# if the URL has extra parameters i.e. sort = recent then order by created_at desc else do the usual stuff
		# if the filter equals featured then just get the is_featured stories

		if params[:sort] == "recent"
			# double equals means compare two things together
			# sort by most recent
			@stories = Story.order("created_at desc")

		elsif params[:filter] == "featured"

			@stories = Story.where(is_featured: true).order("title asc")


		else 	

			@stories = Story.order("votes_count desc, created_at desc")
			#sort by most voted

		end	


	end	

	# show an individual story page
	# This ACTION says i want to display a specific story. Steps are: Find the STORY in the Story database that CORRESPONDS to the :id from 
	# the URL '/stories/:id' and place it in the variable '@story'. Then once the '@story' variable is defined, call the /show.html.erb view 
	# and place into the page. The URL itself was defined earlier in the index.html.erb page with story_path(story).     

	# The params object is a container that enables you to pass values between method calls. For example, when you're on the page called by 
	# the index method, you can click a link for a specific story's comments, and it passes the id of that story's comments via the params 
	# object so that show can find the specific comments.

	def show 
		# params[:id] is from the URL, e.g. if /stories/7 then [:id] = 7
		@story = Story.find(params[:id])


	end	

	# this is going to be the "adding new story" form page

	def new	
		# make @story be a blank story ready to be filled in
		@story = Story.new # '.new' means create a new row in the database


	end	

	# new and create work together as a pair. The create action actually adds what's been "newly" added on the page to the database

	def create 

		
		@story = Story.new(story_params)

		# actually save this story to the database IF validation is passed
		# if don't pass show the form with errors
		
		if @story.save 

			#let's add an addition success notification

			flash[:success] = "Successfully submitted story!"

			# once saved let's redirect to the homepage

			redirect_to root_path

		else

			# if the story doesn't save, then show the new.html.erb form with the errors. 
			# Using RENDER allows to present the previously submitted form with the errors on (this is default)

			render "new"

		end	

	end	

	# i want to show the edit form for an individual story

	def edit 
		# now want to find the story based on the URL
		@story = Story.find(params[:id])


	end	

	# i want to update the database with the edited story

	def update
		@story = Story.find(params[:id])

		# update the story record in the database with the edited story
		if @story.update(story_params)

			# update success
			flash[:success] = "Successfully updated story!"

			# once saved let's redirect to the story page

			redirect_to story_path(@story)

		else 
			
			# if it doesn't update show the edit form with the errors on 
			render "edit"

		end

	end	

	# let's enable destroy/delete a story 

	def destroy 

		@story = Story.find(params[:id])

		@story.destroy

		# destroy success
		flash[:success] = "Successfully deleted story!"

		redirect_to root_path


	end	

		# i want to get the information that the user entered into the form. Given it a name i've made up "story_params"
	
	def story_params 
			# only get the title, desc and link from the story form parameters
			params.require(:story).permit(:title, :description, :link)

		
	end	


		



end
