module Box
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
