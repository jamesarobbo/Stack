class Vote < ActiveRecord::Base

#let the vote know about the story it' related to AND let the story keep track of how many votes it has
	belongs_to :story, counter_cache: true

	# want to check that the ip address is unique for that story
	validates :ip_address, uniqueness: {scope: :story_id}

	#if we only had uniqueness: true that would mean one vote across the entire site per ip address


end
