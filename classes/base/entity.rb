class Entity
  attr_reader :shape, :body

  def initialize(window, map, position_vector)
    @map = map
    @window = window

    @body = CP::Body.new(10.0, 1.0)
    @body.object = self
    @shape = nil
    @body.p = position_vector || CP::Vec2.new(0.0, 0.0)
    @body.v = CP::Vec2.new(0.0, 0.0)
  end

  def boundaries
    verts = []
    if @shape.is_a? CP::Shape::Poly
      for vert in 0..(@shape.num_verts-1) do
        verts << CP::Vec2.new(@shape.body.p.x - @shape[vert].x, @shape.body.p.y - @shape[vert].y)
      end
    end
    return verts
  end

  def draw
    @image.draw(@shape.body.p.x, @shape.body.p.y, 0)
  end

  def draw_boundaries(color=0xffffff00)
    _boundaries = boundaries
    vert_indices = (0.._boundaries.size-1).to_a << 0
    vert_indices.each_cons(2) do |index|
      v1 = _boundaries[index[0]]
      v2 = _boundaries[index[1]]
      @window.draw_line(v1.x, v1.y, color, v2.x, v2.y, color)
    end
  end

end