require 'dxruby'
require 'dxrubyex'
require_relative "title_scene"
require_relative "howto"
require_relative "game_scene"
require_relative "game_scene2"
require_relative "game_scene3"
require_relative "over_scene"
require_relative "clear_scene1"
require_relative "clear_scene2"
require_relative "op_scene"
require_relative "ed_scene"
require_relative "bounus_scene"
require_relative "result_scene"
require_relative File.join('characters', 'player')


Scenes = {
  :title    => TitleScene.new,
  :howto     => HowTo.new,
  :game     => GameScene.new,
  :game2     => GameScene2.new,
  :game3     => GameScene3.new,
  :over     => OverScene.new,
  :op       => OpScene.new,
  :ed       => EdScene.new,
  :bounus   => BounusScene.new,
  :result   => ResultScene.new,
  :clear1 => ClearScene1.new,
  :clear2 => ClearScene2.new,
}

# 最初はタイトル画面から
scene = Scenes[:title]
scene.start

Window.width = 500
Window.height = 600

# メインループ
Window.loop do
next_scene = scene.act
	if next_scene                   # next_scene が nil (か false) でなければ
        scene = Scenes[next_scene]    # 新しいシーンに移動する
        scene.start
    end

    scene.draw
end
