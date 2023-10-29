# frozen_string_literal: true

module Moveable
  ACCELERATION = 2
  FRICTION_SPEED = 0.9
  ROTATION_SPEED = 3.0

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= FRICTION_SPEED
    @velocity_y *= FRICTION_SPEED
    if @x > @window.width - @radius
      @velocity_x = 0
      @x = @window.width - @radius
    end
    if @x < @radius
      @velocity_x = 0
      @x = @radius
    end
    if @y > @window.height - @radius
      @y = @window.height - @radius
    end
  end

  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end

  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end
end
