require "dxrubyex"

class Character
  attr_accessor :collision, :x, :y, :flag,:counter,:image;
  def initialize(director,x = 250, y = 568, image_file = nil)
    @director = director
    @x, @y = x, y
    @speed = 2
	@image = char_image(image_file)
    @collision = CollisionBox.new(self, 0, 0,
                                   @image.width, @image.height)
    @counter = 0
    @flag = 0
  end

  def move
    reset_collision_pos
  end

  def draw
    Window.draw(@x, @y, @image)
  end

  private

  def reset_collision_pos
    self.collision.set(@x, @y)
  end

end
