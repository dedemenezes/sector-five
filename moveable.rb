module Moveable

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= 0.9
    @velocity_y *= 0.9
  end

  def accelerate
    @velocity_x += Gosu.offset_x(@angle, 2)
    @velocity_y += Gosu.offset_y(@angle, 2)
  end

  def turn_right
    @angle += 3.0
  end

  def turn_left
    @angle -= 3.0
  end
end
