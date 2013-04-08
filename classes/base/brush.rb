class Brush < Entity
  attr_reader :shape, :body

  def initialize(window, map, position_vector)
    @map = map
    @window = window

    @image = Gosu::Image.new(window, load_res("demotile.png"), false)

    @body = CP::Body.new(1.0, 1.0)
    @body.object = self
    shape_array = [
      CP::Vec2.new(0, -32),
      CP::Vec2.new(-32, -32),
      CP::Vec2.new(-32, 0),
      CP::Vec2.new(0, 0)
    ]
    @shape = CP::Shape::Poly.new(@body, shape_array, CP::Vec2.new(0,0))
    @shape.object = self
    @shape.body.p = position_vector || CP::Vec2.new(0.0, 0.0)
    @shape.body.v = CP::Vec2.new(0.0, 0.0)
    @shape.collision_type = :brush
  end

end