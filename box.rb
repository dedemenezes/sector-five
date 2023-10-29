# frozen_string_literal: true

module Box
  def on_screen?
    @x > left_edge &&
      @x < right_edge &&
      @y > top_edge &&
      @y < bottom_edge
  end

  def left_edge
    @radius
  end

  def top_edge
    @radius
  end

  def right_edge
    @window.width - @radius
  end

  def bottom_edge
    @window.height - @radius
  end
end
