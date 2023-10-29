class Enemy
  SPEED = 1.7

  def initialize(window)
    @image = Gosu::Image.new('images/enemy.png')
    @radius = 20

    @x = rand(window.width - 2 * @radius) + @radius
    @y = rand + @radius
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def move
    @y += SPEED
  end
end
