require_relative 'character'

class PlayerShot < Character
  attr_accessor :collision
  def initialize(director,x = 250, y = 568, image_file = nil)
    @removed = false
    @x = x
    @y = y
    @collision = CollisionBox.new(self, 0, 0, 30, 30)
    super
  end
  
  def draw
    super
    x1, y1, x2, y2 = @collision.getHitRange
    Window.draw(x1, y1, Image.new(x2-x1, y2-y1))
  end

  def move
    @y -= 10
    @collision.set(@x,@y)
    @removed = true if @y < 80
    if @removed
      remove
	
    end
    
#     collisions = draw_items.map{|i| i.collision } #add
  end
  def remove
    @director.shots.delete_if {|shot| shot == self }
    @collision.delete
     p "rem"
  end
#  def remove

  #end

#enemy‚Ådamage‚ð’è‹`‚µ‚Ä‚Ù‚µ‚¢
  def hit(obj)
    return unless obj.class == Enemy
    @removed = true
     obj.damage+= 1
     
    p "obj.damage"
  end
 
private
  def char_image(image_file = nil)
    image_file ||= File.join(File.dirname(__FILE__), "..", "images", "ishi.png")
    img = Image.load(image_file)
    img.setColorKey([0, 0, 0])
    return img
  end
  
end
