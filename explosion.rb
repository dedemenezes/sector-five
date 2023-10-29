# frozen_string_literal: true

class Explosion
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
    @radius = 30
    @finished = false
    @image_index = 0
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
end
