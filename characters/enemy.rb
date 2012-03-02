class Enemy
  attr_accessor :damage, :collision
  def initialize(director,x = 250, y = 568, image_file = nil)
   
    @x = rand(Window.width) 
    @y = 100 + rand(Window.height / 2 - 80)
	
      # 左右どちらに移動するかを決定
    #@direction = rand(2) - 1
    @image = Image.load("images/enemy.png")
    @director = director
    @speed = 3 * ( 1 - ( rand(2) * 2 ) )
    @damage = 0
    @caught = false
    @sound = Sound.new("BGM/weaponstone.wav")
    @sound2 = Sound.new("BGM/netRelease.wav")
    @collision = CollisionBox.new(self,0,0,30,30)
		
		@hasi = 100
		@moku_y = @y.to_i
	
    super
  end
   def hit(obj)
     
 	if obj.class == PlayerShot
		p "shot"
		p @damage
		@sound.play
		@damage += 1
		obj.remove	
	end
	if obj.class == Net
		p "caught" 
		@caught = true
		@sound2.play
		obj.remove
	end
	#return unless obj.class == Enemy
	
    	remove
   
  end
  # 左右を移動
  def move
        @x += @speed
      	@collision.set(@x,@y)
			if rand(100) == 99
				@moku_y = rand(Window.height / 2 - 80) + 80
			end

			if @moku_y != @y
				if @moku_y > @y
					@y += 2
				else
					@y -= 2
				end
				if ( @y - @moku_y ).abs < 5
					@y = @moku_y
				end
			end
			#画面の端ならスピードダウン
				if ( @x < @hasi ) || ( @x > Window.width - @hasi )
					if @speed < 0
						@speed = -1
					else
						@speed = 1
					end
				else
					if @speed < 0
						@speed = -3
					else
						@speed = 3
					end
				end
				
			#画面外に出たときの処理
      if @x < 0 and @speed < 0
				@speed *= -1
			elsif @x > Window.width - 32 and @speed > 0
        @speed *= -1
      end

  end

  # 削除条件
  def remove
    if @damage == 1
    @image = Image.load("images/enemy3.png")
    end

    if @damage == 2
      @image = Image.load("images/enemy2.png")
    end

      # 石が3回当たった場合 
   
    if @damage == 2 && @caught == true
      p "get!"
      @director.enemies.delete_if {|shot| shot == self }
      @collision.delete
      $count_noumin += 1
    

      # 石が4回当たった場合
    elsif @damage == 3
      @director.enemies.delete_if {|shot| shot == self }
      @collision.delete
    end
	@caught = false
  end
  def del
	 @director.enemies.delete_if {|shot| shot == self }
      @collision.delete
  end
  def draw
    Window.draw(@x, @y, @image)    
    x1, y1, x2, y2 = @collision.getHitRange
    Window.draw(x1, y1, Image.new(x2-x1, y2-y1))
  end
end
