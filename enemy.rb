# frozen_string_literal: true
require_relative 'box'

class Enemy
  include Box
  attr_reader :x, :y, :radius, :window

  def initialize(window)
    @image = Gosu::Image.new('images/enemy.png')
    @radius = 10

    @x = rand(window.width - 2 * @radius) + @radius
    @y = rand + @radius
    @window = window
    random = rand
    @speed = random < 0.5 ? random + 1 : random
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def move
    @y += @speed
  end
end
