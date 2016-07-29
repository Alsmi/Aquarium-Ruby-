class Fish

	attr_accessor :name, :x, :y, :age, :weight
	attr_reader :gender
	
	GENDER = [:male, :female]

	def initialize x, y
		@age = 1
		@gender = GENDER.sample
		@weight = rand(1..4)
		@x 		= x
		@y 		= y
		@name = name
	end

	def can_reproduce? fish
		gender != fish.gender && age >= 3 && fish.age >=3 && name == fish.name
	end

	def die
		@weight = 0
	end

	def gain_weight
		@weight += 0.5
	end

	def grow_thin
		@weight -= 0.5
	end

	def can_eat? fish
		name == "Щ" && fish.name == "К"
	end

	def eat fish
		@weight += fish.weight
	end


end