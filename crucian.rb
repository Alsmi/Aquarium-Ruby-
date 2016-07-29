class Crucian < Fish

	def initialize x, y
		super
		@name 	= "К"
	end

	def reproduce x, y
		Crucian.new x, y
	end
end