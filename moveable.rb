# frozen_string_literal: true

module Moveable
  ACCELERATION = 0.42
  FRICTION_SPEED = 0.962
  ROTATION_SPEED = 2.87

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION_SPEED
    @velocity_y *= FRICTION_SPEED

    if at_right_edge?
      @velocity_x = 0
      @x = right_edge
    end

    if at_left_edge?
      @velocity_x = 0
      @x = player_edge
    end
    return unless at_bottom_edge?

    @velocity_y = 0
    @y = bottom_edge
  end

  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end

  def player_edge
    @radius
  end

  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end

  def at_left_edge?
    @x < player_edge
  end

  def at_right_edge?
    @x > right_edge
  end

  def right_edge
    @window.width - @radius
  end

  def at_bottom_edge?
    @y > bottom_edge
  end

  def bottom_edge
    @window.height - @radius
  end
end
