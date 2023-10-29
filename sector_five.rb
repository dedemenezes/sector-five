require 'gosu'
require_relative 'player'

class SectorFive < Gosu::Window
  def initialize
    super(800, 600)

    self.caption = 'Sector Five'

    @player = Player.new(self)
  end

  def update
    @player.turn_left if self.button_down?(Gosu::KB_LEFT)
    @player.turn_right if self.button_down?(Gosu::KB_RIGHT)
  end

  def draw
    @player.draw
  end
end

window = SectorFive.new
window.show
