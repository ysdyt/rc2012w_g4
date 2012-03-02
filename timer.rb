#22日　11:35 トッキー
class Timer
	attr_accessor :dt, :end_flag	
	def initialize
	
		@fonts = {
		  "normal" => Font.new(30),
		  "big" => Font.new(35),
		}
		@color = {
			"black" => [0,0,0],
			"red" => [255,0,0],
			"yellow" => [255,255,0]
		}
		@font = @fonts["normal"]
		@start_t = Time.now
		@end_t = @start_t + 120  # 制限時間設定
		@dt = 0
		@end_flag = false
	end
	def finish
		@end_t = Time.now
		@end_flag = true
	end 
	def t_draw
		
	
		@dt = @end_t - Time.now
	
		min = @dt.to_i/60
		sec = @dt%60
		if @end_flag == false
	
			if (@dt - 10) <= 0#残り１０秒での処理
				@font = @fonts["big"]
				Window.drawFont(10,10,"#{min}:#{sprintf('%05.2f',sec.to_f)}",@font,:color => @color["red"])
			else	
		
				Window.drawFont(10,10,"#{min}:#{sprintf('%05.2f',sec.to_f)}",@font,:color => @color["black"])
			end
		else 
			end
		
	end
	def t_get
		return @dt.to_i
	end
		
end