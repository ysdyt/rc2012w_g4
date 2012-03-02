# coding: Windows-31J

class Map
  MAP_TILE_IMAGE = File.join(File.dirname(__FILE__), "images", "maptile.png")
  CHIP_SIZE = 32
  SCREEN_WIDTH = 25
  SCREEN_HEIGHT = 19
  attr_accessor :delete

  def initialize(player)
    @player = player
    @map_data = map_load("map.dat")
    #@y = 14
		@y = 14
    @count = CHIP_SIZE
    @delete = false
    @muteki_time = 0    #------------------------------追加　　トッキー
    temp = Image.load(MAP_TILE_IMAGE)
    chip_width  = temp.width / CHIP_SIZE
    chip_height = temp.height / CHIP_SIZE
    @map_chips = Image.loadToArray(MAP_TILE_IMAGE, chip_width, chip_height)
		#プレイヤーの真ん中X座標
		@senter_x = player.x + 16
		@senter_y = player.y + 16
		@carrent_chip_x = ( @senter_x / 32 ).truncate
		@carrent_chip_y = ( @senter_y / 32 ).truncate

		#デバ
		@font = Font.new(64)
		@f = 0
	$clear_flag = true
	
  end

  def draw
  
    #x = (@player.x / 5)
    Window.drawTile(0, 0, @map_data, @map_chips,
                  0, @y * CHIP_SIZE + @count,
                  SCREEN_WIDTH, SCREEN_HEIGHT, 0)
		#Window.drawFont( 50, 50, "x:#{@carrent_chip_x},y:#{@carrent_chip_y},f:#{@f}", @font,:color => [255,255,0])
     update
  end


  private

  def update
	@muteki_time -= 1#-------------------追加　トッキー
		@count -= 1

    if @count < 0
      @count += 32
      @y -= 1
      @y = @map_data.size - 1 if @y < 0
		#p @map_data.size
		#@y += 99 - 19 if @y < 0
    end
	if @counter == 1.0
     	     @player.rechange
	end
		case current_chip
		#落とし穴
		when 2,3
			$count_noumin -= 1
			if $count_noumin < 0
				$count_noumin = 0
			end

			@player.change
			Window.drawFont(50,100,"しまった！",@font,:color => [255,0,0])
			$otoshi = true
			$clear_flag = false
			$timer.finish
		#くさむすび
		when 4
			@player.speed_down(1)
			@player.change
			@player.flag = 1
		#木
		when 10,11,14,15
			if @muteki_time <= 0#------------------------------追加

				$count_noumin -= 1
				@player.change
				@player.flag = 1
				if $count_noumin < 0
					$count_noumin = 0
				end
				@muteki_time = 2*60#-----------------------追加
			end#----------------------追加
		end
			if @player.flag == 1
				p @player.counter
				@player.counter += 1
				if @player.counter > 2 * 60
					@player.image = @player.char_image
					@player.counter = 0
					@player.flag = 0
				end
			end
		
		
	  
  end

  def map_load(dat_file)
    map_file = File.join(File.dirname(__FILE__), "map_data", dat_file)
    dat = []
    File.open(map_file) do |f|
      f.each do |line|
        dat << line.chomp.split(/\s*,\s*/).map{|chip| chip.to_i}
      end
    end
    return dat
  end

  def current_chip

		#更新して
		@senter_x = @player.x + 16
		#キャラの位置がマップのどれにあたるか
		#@carrent_chip_x = ( @senter_x / 32 ).truncate
		#@carrent_chip_y = ( @senter_y / 32 ).truncate


		#マウスがマップのどれにあたるか
		#@senter_x = Input.mousePosX
		#@senter_y = Input.mousePosY
		@carrent_chip_x = ( @senter_x / 32 ).truncate
		@carrent_chip_y = ( ( @senter_y + @count ) / 32 ).truncate
		if 	@carrent_chip_x < 0
				@carrent_chip_x = 0
		end
		if 	@carrent_chip_y < 0
				@carrent_chip_y = 0
		end

		  @f = @map_data[(@carrent_chip_y + @y) % @map_data.size][@carrent_chip_x]
		  return @f
          #p "@carrent_chip_y:#{@carrent_chip_y} @y:#{@y} @carrent_chip_x:#{@carrent_chip_x}"

	end
end
