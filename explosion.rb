# frozen_string_literal: true

class Explosion
  def initialize(window, x, y, angle, speed)
    @window = window
    @x = x
    @y = y
    @angle = angle
    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
    @radius = 30
    @finished = false
    @image_index = 0
    @speed = speed
  end

  def finished?
    @finished
  end

  def draw
    if @image_index < @images.count
      @images[@image_index].draw(@x - @radius, @y - @radius, 2)
      @image_index += 1
    else
      @finished = true
    end
  end

  def move
    # speed = Gosu.distance(enemy.x, )
    @x += Gosu.offset_x(@angle, real_speed)
    @y += Gosu.offset_y(@angle, real_speed)
  end

  private

  def real_speed
    @speed.fdiv(3)
  end
end
