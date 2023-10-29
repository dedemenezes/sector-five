# frozen_string_literal: true

require 'gosu'
require_relative 'player'

# Runs the game
class SectorFive < Gosu::Window
  def initialize
    super(800, 600)

    self.caption = 'Sector Five'

    @player = Player.new(self)
  end

  def update
    @player.turn_left if button_down?(Gosu::KB_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT)
    @player.accelerate if button_down?(Gosu::KB_UP)
    @player.move
  end

  def draw
    @player.draw
  end
end

window = SectorFive.new
window.show
