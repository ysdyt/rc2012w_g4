class ResultScene
    def initialize
		@font = Font.new(64)
		@image = Image.load("images/kofun_l.png")
	@count = 0
        @bgm=Sound.new("BGM/op.wav")
    end

    def start
    end

    def act
	Window.drawFont(50,100,"#{$counter_noumin}",@font,:color => [255,0,0])
    	return false
    end
    
    def draw
			
		Window.draw(100,50,@image)
    end
end
