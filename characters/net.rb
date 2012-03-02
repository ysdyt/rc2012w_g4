# —‰º‚µ‚È‚¢‚ÆÁ‚¦‚È‚¢
#  @collision.setRange(0,0,0,0)
class Net < Character
	attr_accessor :collision
# first: ‰Ÿ‚µ‚½‚æ
	def initialize(director, x = 400, y = 550, image_file = nil)
		@removed = false
		@y = y
		@x = x
		@image = char_image(image_file)
		@collision = CollisionBox.new(self,0,0,30,30)
		super
	end

#move‚Æremove‚Å‚Á‚·
	def move
		@y -= 10
		@collision.set(@x,@y)
		@removed = true if @y < 0
		if @removed
		  @director.nets.delete_if {|shot| shot == self }
		$power = 0
		  p "rem"
	 	end
		p @y
		p $power
		if @y <= 500 - 5*$power
		  @removed = true
		$power = 0
		  p "p"
		end
#     collisions = draw_items.map{|i| i.collision } #add
	end


  	def hit(obj)
	p "obj.caught"
    	return unless obj.class == Enemy
    	remove
    
  	end

   def remove
    @director.nets.delete_if {|shot| shot == self }
    @collision.delete
     p "rem"
   end
	def char_image(image_file = nil)
    	image_file ||= File.join(File.dirname(__FILE__), "..", "images", "net.png")
    	img = Image.load(image_file)
    	img.setColorKey([0, 0, 0])
    	return img
  	end

	
end