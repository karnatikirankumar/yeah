require 'rubygame'

# Bindings to the native desktop powered by Rubygame.
class Yeah::Desktop
  # @!attribute [r] screen
  #   @return [Rubygame::Screen]
  # @!attribute resolution
  #   @return [Vector] size of game window
  # @!attribute tickrate
  #   @return [Integer] target ticks per second
  attr_reader :screen, :resolution, :tickrate

  def initialize(resolution=Vector[320, 180])
    self.resolution = resolution
    @clock = Rubygame::Clock.new
    self.tickrate = 30
  end

  def resolution=(value)
    @screen = Rubygame::Screen.new(value.components[0..1])
    @resolution = value
  end

  def tickrate=(value)
    @clock.target_framerate = value
    @tickrate = value
  end

  # Project a surface onto screen.
  # @param [Surface]
  def render(surface)
    struct = screen.send(:struct)
    struct.pixels.write_string(surface.data(:bgra), surface.data.length)
    screen.update
  end

  # Execute passed block on each tick.
  # @yield
  def each_tick
    loop do
      yield
      @clock.tick
    end
  end
end
