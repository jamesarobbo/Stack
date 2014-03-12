class VotesController < ApplicationController

# only need a create method because don't need a form for the user to fill in. Either the person votes or doesn't

def create

	# find the story that we want to vote on

	@story = Story.find(params[:story_id])

	# make a new vote on that story

	@vote = @story.votes.new(ip_address: request.ip)

	# save it

	if @vote.save

		# let the user know
		flash[:success] = "You've upvoted this story"

	else

		flash[:failure] = "You've upvoted already"

	end	

		redirect_to story_path(@story)
end	

end
