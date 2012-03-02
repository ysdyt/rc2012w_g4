class TitleScene
    def initialize
        @title = Image.load("images/title.png")
		@select01 = Image.load("images/kofun_s.png")
		@select02 = Image.load("images/kofun_m.png")
		@select03 = Image.load("images/kofun_l.png")
		@select01_c = Image.load("images/kofun_c_s.png")
		@select02_c = Image.load("images/kofun_c_m.png")
		@select03_c = Image.load("images/kofun_c_l.png")
		@images = [@select01,@select02,@select03]
		@images_c = [@select01_c,@select02_c,@select03_c]
		$select = 0
    @bgm = Sound.new("BGM/opbgm.wav")
    end
attr_accessor :select;
    def start
          @bgm.play
	  $select = 0
    end

    def act
		if Input.keyPush?( K_DOWN )
			#下いけたら下
			if $select < 2
				$select += 1
			else
				$select = 0
			end
		elsif Input.keyPush?( K_UP)
			#上
			if $select > 0
				$select-= 1
			else
				$select = 2
			end
		elsif Input.keyPush?( K_RETURN)
				if $select == 0
				@bgm.stop
				   return :op
				else
				@bgm.stop
				   return :howto
				end
		end
    	return false
    end
    
    def draw
		#タイトル画面表示
        Window.draw(0,0,@title)
		for k in 0 ... 3
			#選んでいるやつだったら
			if k == $select
				Window.draw(300,300 + k * 70,@images_c[k])
			else
				Window.draw(300,300 + k * 70,@images[k])
			end
		end
    end
end
