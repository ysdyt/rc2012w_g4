#encoding: Shift_JIS
class HowTo
    def initialize
		@setumei = Image.load("images/setumei1.png")
		@setumei2 = Image.load("images/setumei2.png")
		@bgm = Sound.new("BGM/story.wav")
		#$select = 0 #多分初期化する必要なし
    end

    def start
	@how_flag1 = true
	@how_flag2 = false
    end

    def act
	if @how_flag1 == true
		Window.draw(0,0,@setumei)
		if Input.keyPush?( K_RETURN)
	        	@how_flag1 = false
			@how_flag2 = true
		end
	elsif @how_flag2 == true
		Window.draw(0,0,@setumei2)
		if Input.keyPush?( K_RETURN)
			case $select
			when 0
			@bgm.stop
				return :game
			when 1
			@bgm.stop
				return :game2
			when 2
			@bgm.stop
				return :game3
			end
		end

	end
    	return false
    end
    
    def draw

    end

end
