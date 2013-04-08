include Loader

class Player < Entity
  def initialize(window, map, position_vector=nil)
    super

    @image = Gosu::Image.new(window, load_res("playa1.png"), false)
    @height = @image.height
    @width = @image.width

    @body = CP::Body.new(1.0, 1.0)
    @body.p = CP::Vec2.new(map.start_pos[0], map.start_pos[1])
    @body.object = self
    @body.v_limit = 100.0

    shape_array = [
      CP::Vec2.new(0, 0),
      CP::Vec2.new(0, -30),
      CP::Vec2.new(-16, -30),
      CP::Vec2.new(-16, 0)
    ]
    # CP::recenter_poly(shape_array)
    @shape = CP::Shape::Poly.new(@body, shape_array, CP::Vec2.new(0,0))
    @shape.object = self
    @shape.collision_type = :player

    @dir = :right
  end

  def x; @body.p.x.floor; end
  def y; @body.p.y.floor; end
  def vel; [@body.v.x.round(2), @body.v.y.round(2)]; end

  def warp(point)
    @body.p = point
  end

  def move_left
    @dir = :left
    @body.apply_force CP::Vec2.new(-100.0, 0.0), CP::Vec2.new(0.0, 0.0)
  end

  def move_right
    @dir = :right
    @body.apply_force CP::Vec2.new(100.0, 0.0), CP::Vec2.new(0.0, 0.0)
  end

  def jump
    @body.apply_force CP::Vec2.new(0.0, -100.0), CP::Vec2.new(0.0, 0.0)
  end

  def draw
    if @dir == :left then
      offs_x = 0
      factor = 1.0
    else
      offs_x = @width
      factor = -1.0
    end
    # @image.draw_rot(@shape.body.pos.x, @shape.body.pos.y, 1, 0, 0.5, 0.5, 1, 1)
    @image.draw(@shape.body.p.x + offs_x, @shape.body.p.y, 0, factor, 1.0)
    @body.reset_forces
  end

end