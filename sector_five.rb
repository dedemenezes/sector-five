# frozen_string_literal: true

require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'

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
    @bullets = []
  end

  def update
    @enemies << Enemy.new(self) if rand < ENEMY_FREQUENCY
    @enemies.each(&:move)

    @player.turn_left if button_down?(Gosu::KB_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT)
    @player.accelerate if button_down?(Gosu::KB_UP)
    @player.move

    @bullets.each(&:move)
  end

  def draw
    @player.draw
    @enemies.each(&:draw)
    @bullets.each(&:draw)
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end
end

window = SectorFive.new
window.show
