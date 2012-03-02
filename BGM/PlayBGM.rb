require 'dxruby'

bgm = Sound.new("playbgm.wav")  # bgm.mid“Ç‚İ‚İ

bgm.play

Window.loop do
  if Input.keyPush?(K_ESCAPE)
    break
  end
end
