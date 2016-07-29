class Pike < Fish

	def initialize x, y
		super
		@name 	= "Щ"
	end

	def reproduce x, y
		Pike.new x, y
	end
end