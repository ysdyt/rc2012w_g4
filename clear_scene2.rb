class ClearScene2
    def initialize
        @image = Image.load("images/cl2.png")
        @bgm=Sound.new("BGM/gameclear.wav")
    end

    def start
        @bgm.play
    end

    def act
	if Input.keyPush?(K_RETURN)
          @bgm.stop
	  return 	:title
        end
    	return false
    end
    
    def draw
        Window.draw(0,0,@image)
    end
end






