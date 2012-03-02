# encoding: Shift_JIS 
require_relative File.join('characters', 'player')
require_relative File.join('characters', 'net')
require_relative File.join('characters', 'shot')
require_relative File.join('timer')
require_relative File.join('map')

require_relative File.join('characters', 'enemy')

class GameScene
  attr_accessor :player, :enemies, :shots, :nets
    def initialize
	
		@enemies = []
		10.times { @enemies << Enemy.new(self, rand(), rand())} # 敵の数指定
		@player = Player.new(self, 250, 500)	
		@map = Map.new(@player)
    		$timer = Timer.new
		@nets = []
		@shots = []
		#縄関係
		$power = 0
		@count = 0
		@font = Font.new(23)
		@font2 = Font.new(15)
		$count_noumin = 0
                @bgm= Sound.new("BGM/playbgm.wav")
       		@bg = Image.load("images/bg.png")
		@Sound=Sound.new("BGM/NetCharge.wav")
                @Sound.loopCount = -1
		@nawa_sound_f = 0
    end

    def start
		10.times{|n|
			@enemies[n] = Enemy.new(self, rand(), rand())
		}
			#a.damage = 0
		
		@player.x = 250
		@player.y = 500
    		$timer = Timer.new
		#縄関係
		$power = 0
		@count = 0
		$count_noumin = 0
        @bgm.play
    end

    def act
	if @enemies.size < 10 
		@enemies << Enemy.new(self, rand(), rand())
	end	
	Input.setKeyRepeat( K_S,1,1 )
	if Input.keyPush?(K_A)
		@shots << PlayerShot.new(self, @player.x, @player.y-40)
	end
		#押している間パワーチャージ
    	if Input.keyPush?(K_S)
      		if @nawa_sound_f == 0
                	@Sound.play
			@nawa_sound_f = 1
		end
      		@count += 1
              
		#離したときパワーをためていたら縄発射
    	elsif   @count > 0
		@nawa_sound_f = 0
		@Sound.stop
		@nets << Net.new(self, @player.x, @player.y-40)
		$power = @count
		@count = 0
	end

	@player.move

    	draw_items.each do |char|
      		char.move  # キャラクタに移動を命じる
	end	
	
	check_collision # 当たり判定の一括処理
        check_clear     # ゲームクリア条件の判定処理
	if $timer.dt <= 0 
		sleep(1)
		@bgm.stop
		if $count_noumin > 1 && $otoshi == false  #ノルマ
			if $clear_flag == true
				return :clear1
			end
		else
                	$otoshi = false
    			return :over
		end
	end
	return false
    end
    
    def check_collision
      collisions = draw_items.map{|c| c.collision }.compact
      Collision.check(collisions, collisions)
    end
   
    def draw
	@map.draw
	#$timer.t_draw
	draw_count
	#Window.drawFont(280,20,"捕獲人数："+$count_noumin.to_s+"人",@font,:color => [0,0,0])
        # 画面上に描画するべき全ての要素を処理する
    	draw_items.each do |char|
      		char.draw  # キャラクタの画像を画面に表示させる
    	end
    end
      def check_clear
    if Input.keyPush?(K_RETURN)
      # シーンを切り替え、エンディングシーンへ遷移
      @bgm.stop
      return :clear1
    end
  end

	#画面上に描画するべき全ての要素を1つの配列として返す
  	def draw_items
    	return [@player] + @nets + @shots + @enemies
  	end
	def draw_count
		Window.draw(0,-20,@bg)
		$timer.t_draw
		Window.drawFont(140,14,"捕獲人数："+$count_noumin.to_s+"人",@font,:color => [0,0,0])
		Window.drawFont(320,10,"a ： 石を投げる\ns ： 長押しで力をため、\n　   キーを離して網を投げる\n矢印キー左右 ： 移動",@font2,:color => [0,0,0])
	end
end
