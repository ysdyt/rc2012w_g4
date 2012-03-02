class OverScene
    def initialize
        @image = Image.load("images/game_over.png")
	@count = 0
        @bgm=Sound.new("BGM/op.wav")
    end

    def start
        @bgm.play
	@count = 0
    end

    def act
			@count += 1
			if @count >= 60 * 5
                                @bgm.stop
				return :title
			end
    	return false
    end
    
    def draw
        Window.draw(0,0,@image)
    end
end
