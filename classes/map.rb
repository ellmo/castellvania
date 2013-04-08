class Map
  attr_reader :width, :height, :brushes, :start_pos

  def initialize(window, filename)
    lines = File.readlines(filename).map { |line| line.chomp }
    @brushes = []
    @window = window
    @space = window.space
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when '#'
          brush = Brush.new(window, self, CP::Vec2.new(x*32, y*32))
          @brushes << brush
          # @space.add_body(brush.body)
          @space.add_shape(brush.shape)
        when 's'
          @start_pos = [x*32,y*32]; nil
        else
          nil
        end
      end
    end
  end

  def draw
    @brushes.each {|brush| brush.draw}
  end

  def draw_boundaries
    @brushes.each {|brush| brush.draw_boundaries}
  end
end