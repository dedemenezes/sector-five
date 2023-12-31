# frozen_string_literal: true

require_relative 'moveable'

# SHIP
class Player
  include Moveable
  attr_reader :x, :y, :angle, :radius

  def initialize(window)
    @window = window
    @image = Gosu::Image.new('images/ship.png')
    @radius = 20

    @x = 200
    @y = 200
    @angle = 0
    @velocity_x = 0
    @velocity_y = 0
  end

  def draw
    # draw_rot(x, y, z = 0, angle = 0, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    @image.draw_rot(@x, @y, 0, @angle)
  end
end
