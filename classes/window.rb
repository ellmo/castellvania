class GameWindow < Gosu::Window
  attr_reader :map, :player, :gui, :space
  def initialize
    $draw_boundaries = false

    super 640, 480, false
    self.caption = "Cast-ell-vania (tm)"

    puts 'Defining physics.'
    @space = CP::Space.new
    @space.gravity = CP::Vec2.new(0.0, 10.0)
    @space.damping = 0.8
    @dt = (1.0/60.0)             # delta time - update frequency

    puts 'Loading map.'
    @map = Map.new self, load_res('map01.txt')

    puts 'Creating objects.'
    @player = Player.new self, @map
    @collisions = []

    @space.add_body(@player.body)
    @space.add_shape(@player.shape)
    @space.add_collision_func(:brush, :brush, &nil)
    @space.add_collision_func(:player, :brush) do |player_shape, brush_shape|
      @collisions << brush_shape
    end

    puts 'Loading GUI.'
    @gui = Gui.new self
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.move_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.move_right
    end
    if button_down? Gosu::KbUp then
      @player.jump
    end
    @space.step(@dt)
  end

  def draw
    @player.draw
    @map.draw
    @gui.draw
    if @collisions and !@collisions.empty?
      @player.draw_boundaries(0xffff2222)
      @collisions.each {|c| c.object.draw_boundaries(0xffff2222)}
    end
    @collisions = []
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      puts 'Quitting (no error).'
      close
    when 50
      $draw_boundaries = !$draw_boundaries
      puts "Drawing collision boundaries: #{$draw_boundaries}"
    end
  end

end