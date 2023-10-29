class Enemy
  SPEED = 1.7
  attr_reader :x, :y, :radius

  def initialize(window)
    @image = Gosu::Image.new('images/enemy.png')
    @radius = 10

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
