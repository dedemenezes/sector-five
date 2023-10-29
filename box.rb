# frozen_string_literal: true
module Box
  def on_screen?
    x > left_edge    &&
      x < right_edge &&
      y > top_edge   &&
      y < bottom_edge
  end

  def left_edge
    radius
  end

  def at_left_edge?
    x < player_edge
  end

  def right_edge
    window.width - radius
  end

  def at_right_edge?
    x > right_edge
  end

  def bottom_edge
    window.height - radius
  end

  def at_bottom_edge?
    y > bottom_edge
  end

  def top_edge
    radius
  end
end
