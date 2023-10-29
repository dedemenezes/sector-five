# frozen_string_literal: true

require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFiveScenes < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05

  def initialize
    super(WIDTH, HEIGHT)

    self.caption = 'Sector Five'
    @background_image = Gosu::Image.new('images/start_screen.png')
    @scene = :start
  end

  def update
    case @scene
    when :game
      update_game
    when :end
      # update_end
    end
  end

  def draw
    case @scene
    when :start
      draw_start
    when :game
      draw_game
    when :end
      draw_end
    end
  end

  def button_down(id)
    case @scene
    when :start
      button_down_start(id)
    when :game
      button_down_game(id)
    else
      "no se"
    end
  end

  private

  def draw_start
    @background_image.draw(0, 0, 0)
  end

  def button_down_start(id)
    initialize_game
  end

  def initialize_game
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
    @scene = :game
  end

  def draw_game
    @player.draw
    @enemies.each(&:draw)
    @bullets.each(&:draw)
    @explosions.each(&:draw)
  end

  def update_game
    # PLAYER
    @player.turn_left if button_down?(Gosu::KB_LEFT)
    @player.turn_right if button_down?(Gosu::KB_RIGHT)
    @player.accelerate if button_down?(Gosu::KB_UP)
    @player.move

    # ENEMIES
    @enemies << Enemy.new(self) if rand < ENEMY_FREQUENCY
    @enemies.each(&:move)

    # BILLETS
    @bullets.each(&:move)

    # COLLISIONS
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        next unless distance < enemy.radius + enemy.radius

        @enemies.delete(enemy)
        @bullets.delete(bullet)
        from_player_to_enemy = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        @explosions << Explosion.new(self, enemy.x, enemy.y, bullet.angle, from_player_to_enemy)
      end
    end

    # EXPLOSIONS
    @explosions.each(&:move)

    # CLEANING
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

  def button_down_game(id)
    return unless id == Gosu::KbSpace

    @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
  end
end

SectorFiveScenes.new.show
