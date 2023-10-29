# frozen_string_literal: true

require 'gosu'
require_relative 'player'
require_relative 'enemy'

# Runs the game
class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(WIDTH, HEIGHT)

    self.caption = 'Sector Five'

    @player = Player.new(self)
    @enemies = []
  end

  def update
    if rand < ENEMY_FREQUENCY
      @enemies << Enemy.new(self)
    end
    @enemies.each(&:move)

    @player.turn_left if button_down?(Gosu::KB_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT)
    @player.accelerate if button_down?(Gosu::KB_UP)
    @player.move
  end

  def draw
    @player.draw
    @enemies.each(&:draw)
  end
end

window = SectorFive.new
window.show
