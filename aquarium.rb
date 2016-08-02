require './fish'
require './crucian'
require './pike'

class Aquarium
	attr_reader :height, :width
	attr_accessor :aquarium, :crucian_count, :pike_count, :fish_list

	def initialize
		@width = width
		@height = height
		@aquarium = aquarium
		@crucian_count = crucian_count
		@pike_count = pike_count
		@fish_list = []

		create_aquarium
	end

	def game
		add_fish
		i = true
		while i do
			i = false if @pike_count == 0 || @crucian_count == 0 || @fish_list.size > @width*@height
			aquarium_show
			next_step
			status
			sleep 3
		end
	end

	def create_aquarium	
		puts "Введите желаемую высоту аквариума:"
		@height = gets.chomp.to_i
		puts "Введите желаемую ширину аквариума:"
		@width = gets.chomp.to_i
		puts "Введите желаемое количество карасиков:"
		@crucian_count = gets.chomp.to_i
		puts "Введите желаемое количество щучек:"
		@pike_count = gets.chomp.to_i

	end

	def add_fish
		@crucian_count.times do
			crucian = Crucian.new rand(0..@width-1), rand(0..@height-1)
			@fish_list << crucian
		end

		@pike_count.times do
			pike = Pike.new rand(0..@width-1), rand(0..@height-1)
			@fish_list << pike
		end		
	end
	
	def aquarium_show
		puts
		@height.times do |i|
			@width.times do |k|
				curent_cell = who_is_here(k,i)
				case curent_cell.size
				when 0
					print "-"
				when 1
					print curent_cell.first.name
				else
					print "*"
				end
			end
			puts
		end
	end

	def who_is_here(x, y)
		@fish_list.select{|fish| fish.x == x && fish.y == y}
	end

	def status
		puts
		puts
		puts "*"*50
		puts "Всего рыб в аквариуме: #{@fish_list.length}"
		@crucian_count = 0
		@pike_count = 0
		@fish_list.each do |fish|
			if fish.name == "К"
				@crucian_count += 1
			elsif fish.name == "Щ"
				@pike_count += 1	
			end			
		end
		puts "Всего КАРАСИКОВ в аквариуме: #{@crucian_count}"
		puts "Всего ЩУЧЕК в аквариуме: #{@pike_count}"
		puts "*"*50
	end

	def next_step
		@fish_list.delete_if{|fish| fish.weight == 0} 

		@fish_list.each do |fish|

			fish.age += 1

			# fish reproduce, fish eat
			current_cell = who_is_here(fish.x, fish.y)

			current_cell.each do |inside_fish|
				if fish.can_reproduce?(inside_fish)
					@fish_list << fish.reproduce(rand(0..(@width-1)), rand(0..(@height-1)))
				end
				if fish.name == "Щ"
					if fish.can_eat?(inside_fish)
						fish.eat(inside_fish)
						inside_fish.die
					elsif !fish.can_eat?(inside_fish) && fish.age % 2 == 0
						fish.grow_thin
					end
				end
			end

			# new coordinates
			if fish.x == 0
				fish.x += rand(0..1)
			elsif fish.x == @width-1
				fish.x += rand(-1..0)
			else
				fish.x += rand(-1..1)
			end

			if fish.y == 0
				fish.y += rand(0..1)
			elsif fish.y == @height-1
				fish.y += rand(-1..0)
			else
				fish.y += rand(-1..1)
			end

			# new curcian weight
			if fish.name == "К" && fish.age % 3 == 0
				fish.gain_weight
			end
		end
	end
		
end