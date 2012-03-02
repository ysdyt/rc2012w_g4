class ClearScene1
    def initialize
        @image = Image.load("images/cl1.png")
        @bgm=Sound.new("BGM/gameclear.wav")
	@count = 0
    end

    def start
        @bgm.play
    end

    def act
        @count += 1

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



  





