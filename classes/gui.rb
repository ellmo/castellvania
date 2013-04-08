class Gui
  def initialize(window)
    @window = window
    @player = window.player
    @map = window.map
    @font = Gosu::Font.new(window, 'Monaco', 20)
  end

  def print_coords
    @font.draw("Coords: X:#{@player.x} Y:#{@player.y}", 110, 10, 1, 1.0, 1.0, 0xddffffff)
  end

  def print_accel
    @font.draw("Velocity: #{@player.vel}", 310, 10, 1, 1.0, 1.0, 0x8dffffff)
  end

  def draw
    print_coords
    print_accel
    @player.draw_boundaries if $draw_boundaries
    @map.draw_boundaries if $draw_boundaries
  end

end