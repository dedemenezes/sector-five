# frozen_string_literal: true

require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'
require_relative 'credit'

class SectorFiveScenes < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.02
  MAX_ENEMIES = 100

  def initialize
    super(WIDTH, HEIGHT)

    self.caption = 'Sector Five'
    @start_music = Gosu::Song.new(File.join(__dir__, 'sounds/start_bg.mp3'))
    @start_music.play(true)

    @background_image = Gosu::Image.new('images/start_screen.png')
    @scene = :start
  end

  def update
    case @scene
    when :game
      update_game
    when :end
      update_end
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
    when :end
      button_down_end(id)
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
    @game_music = Gosu::Song.new(File.join(__dir__, 'sounds/end_bg.mp3'))
    @game_music.play(true)

    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
    @scene = :game
    @enemies_appeared = 0
    @enemies_destroyed = 0
    @explosion_sound = Gosu::Sample.new(File.join(__dir__, 'sounds/explosion.wav'))
    @shooting_sound = Gosu::Sample.new(File.join(__dir__, 'sounds/shoot.wav'))
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
    if rand < ENEMY_FREQUENCY
      @enemies << Enemy.new(self)
      @enemies_appeared += 1
    end
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
        @enemies_destroyed += 1
        @explosion_sound.play
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

    initialize_end(:count_reached) if @enemies_appeared > MAX_ENEMIES
    @enemies.each do |enemy|
      distance = Gosu.distance(enemy.x, enemy.y, @player.x, @player.y)
      initialize_end(:hit_by_enemy) if distance < @player.radius + enemy.radius
    end
    initialize_end(:off_top) if @player.y < @player.radius
  end

  def button_down_game(id)
    return unless id == Gosu::KbSpace

    @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    @shooting_sound.play(0.3)
  end

  def initialize_end(fate)
    @end_music = Gosu::Song.new(File.join(__dir__, 'sounds/game_bg.mp3'))
    @end_music.play(true)

    case fate
    when :count_reached
      @message = "You made it! You destroyed #{@enemies_destroyed} ships"
      @message2= "and #{@enemies_escaped} reached the base."
    when :hit_by_enemy
      @message = "You were struck by an enemy ship."
      @message2 = "Before your ship was destroyed, "
      @message2 += "you took out #{@enemies_destroyed} enemy ships."
    when :off_top
      @message = "You got too close to the enemy mother ship."
      @message2 = "Before your ship was destroyed, "
      @message2 += "you took out #{@enemies_destroyed} enemy ships."
    end
    @bottom_message = "Press P to play again, or Q to quit."
    @message_font = Gosu::Font.new(28)
    @credits = []
    y = 600
    File.open('credits.txt').each do |line|
      @credits.push(Credit.new(self, line.chomp, 100, y))
      y += 30
    end
    @scene = :end
  end

  def draw_end
    clip_to(50, 140, 700, 360) do
      @credits.each(&:draw)
    end
    draw_line(0, 140, Gosu::Color::RED, WIDTH, 140, Gosu::Color::RED)
    @message_font.draw(@message, 40, 40, 1, 1, 1, Gosu::Color::FUCHSIA)
    @message_font.draw(@message2, 40, 75, 1, 1, 1, Gosu::Color::FUCHSIA)
    draw_line(0, 500, Gosu::Color::RED, WIDTH, 500, Gosu::Color::RED)
    @message_font.draw(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color::BLUE)
  end

  def update_end
    @credits.each do |credit|
      credit.move
    end
    if @credits.last.y < 150
      @credits.each do |credit|
        credit.reset
      end
    end
  end

  def button_down_end(id)
    if id == Gosu::KbP
      initialize_game
    elsif id == Gosu::KbQ
      close
    end
  end
end

SectorFiveScenes.new.show
