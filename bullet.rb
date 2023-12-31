# frozen_string_literal: true

require_relative 'box'

# Ship attack bullet
class Bullet
  include Box
  SPEED = 5
  attr_reader :x, :y, :radius, :window, :angle

  def initialize(window, x, y, angle)
    @image = Gosu::Image.new('images/bullet.png')
    @radius = 1.5

    @x = x
    @y = y
    @angle = angle
    @window = window
  end

  def move
    @x += Gosu.offset_x(@angle, SPEED)
    @y += Gosu.offset_y(@angle, SPEED)
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end
