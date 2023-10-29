# frozen_string_literal: true

require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

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
    @explosions = []
  end

  def update
    update_player
    update_enemies
    update_bullets
    war_casualties
    general_cleaning
  end

  def draw
    @player.draw
    @enemies.each(&:draw)
    @bullets.each(&:draw)
    @explosions.each(&:draw)
  end

  def button_down(id)
    return unless id == Gosu::KbSpace

    @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
  end

  private

  def update_player
    @player.turn_left if button_down?(Gosu::KB_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT)
    @player.accelerate if button_down?(Gosu::KB_UP)
    @player.move
  end

  def update_enemies
    @enemies << Enemy.new(self) if rand < ENEMY_FREQUENCY
    @enemies.each(&:move)
  end

  def update_bullets
    @bullets.each(&:move)
  end

  def war_casualties
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        next unless distance < enemy.radius + enemy.radius

        @enemies.delete(enemy)
        @bullets.delete(bullet)
        @explosions << Explosion.new(self, enemy.x, enemy.y)
      end
    end
  end

  def general_cleaning
    @explosions.dup.each do |explosion|
      @explosions.delete(explosion) if explosion.finished?
    end

    @bullets.dup.each do |bullet|
      # puts "####{bullet.on_screen?}#{bullet.on_screen?}#{index}#{index}####"
      @bullets.delete bullet unless bullet.on_screen?
    end

    @enemies.dup.each do |enemy|
      @enemies.delete enemy unless enemy.on_screen?
    end
  end
end

window = SectorFive.new
window.show
