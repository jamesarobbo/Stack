class CommentsController < ApplicationController

	# this controller only needs new and create because we don't want users to edit, delete or view a list

	def new

		# we need to find which story we're talking about and need to make a new comment on that story

		# we need to specifiy that we're looking for a story within the Stories Model so use :story_id. If use just :id it will look 
		# for a comment.

		@story = Story.find(params[:story_id]) # Steps are: Find the STORY in the Story database that CORRESPONDS to the :story_id from 
											   # the URL '/stories/:story_id/comments/new' and place it in the variable '@story'. 
											   # then once the variable is defined call the /new.html.erb comments view and place it in the page.
											   #  :story_id is the foreign key because refers to a different table

		@comment = @story.comments.new 		   # firstly the story was found (above). Now we say to make a new comment for association w/ that story.
											   # comments is from the story.rb model where we declared has_many :comments
	end	

	def create

		@story = Story.find(params[:story_id])
		@comment = @story.comments.new(comment_params) 

		# if the comment is saved, redirect and show a message, else show errors page

		if @comment.save
			flash[:success] = "Your comment has been posted"

			redirect_to story_path(@story)

		else 
		
		render "new"

		end	

	end	

	#let's make a shortcut for whitelisting our form data - ensure only correct information is submitted through the form

	def comment_params

		params.require(:comment).permit(:body) #where is the :comment from?
	
	end	

end
