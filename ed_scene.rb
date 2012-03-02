#encoding: Shift_JIS
class EdScene
    def initialize
       @ed1 = Image.load("images/edscene1.png")
       @ed2 = Image.load("images/edscene2.png")
       @ed3 = Image.load("images/edscene3.png")
       @ed4 = Image.load("images/edscene4.png")
	@font2 = Font.new(60)
	@font = Font.new(20)
       @bgm = Sound.new("BGM/gameclear.wav")
    end

    def start
        @bgm.play
	@fheight = 150
	@edcount = 0
    end

    def act
	if @edcount<120
	        Window.draw(0,0,@ed1)
	elsif @edcount<240
	        Window.draw(0,0,@ed2)
	elsif @edcount<360
	        Window.draw(0,0,@ed3)
	else
		  
		Window.drawFont( 50, 50, "#{@fheight}", @font,:color => [255, 255, 255])

		Window.drawFont( 70, @fheight, "俺は古墳づくりを手伝ってくれる民を確保。\n\nその結果、俺は卑○呼に大きな前方後円墳を\n\nつくってあげることに成功した\n\nそしてこの古墳作りを期に俺は出世した\n\n美人な妻もできた\n\nホントみんなありがとう！！\n\n民のみんなもありがとう！！\n\nみんなのおかげで俺は今幸せだよ！！", @font,:color => [0, 0, 0])
		
		Window.drawFont( 50, @fheight+380, "～ THE END ～", @font2,:color => [0, 0, 0])
		if @edcount%2 == 0 && @fheight > -300
			@fheight -= 1
		end
		if @edcount >= 1500
 			@bgm.stop
			return :title
		end
		Window.draw(0,0,@ed4)
	end
		@edcount += 1
	    	return false
    end
    def draw
	Window.bgcolor = [255, 255, 255]
    end
end
