class Story < ActiveRecord::Base

#this is the story model itself and is where you set specific rules for it

# let's make the code know that there's a relationship between story and comment
# this means a story has many comments. The relationship is one to many. association between models.
	has_many :comments	


#add another relationship between a story and votes. The relationship is one to many.
	has_many :votes


# let's make sure that the data in our database is exactly what we want it to be - validation

# this validation ensures that there must be information present within the title and link fields before the record is created and saved.
# "Active Record Validations - Ruby on Rails Guide" shows all the different validations that you can use
	validates :title, presence: true, length: {minimum: 5, message: "Must be over 5 character long"}
	validates :link, presence: true, uniqueness: {message: "this is not unique"} # do not want duplicate links. At present if submit a duplicate link it 
													  # still says that the save was successful because there is no check in the Controller
													  # to check that the save was successful

	# validates() is a method aka a function

	# :title is a symbol because it doesn't change within the code

	# {presence: true} is a hash



end
