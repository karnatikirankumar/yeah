module Yeah

class Look < Base
  def self.size
    @size
  end
  def self.size=(value)
    @size = value
  end

  def self.anchor
    @anchor
  end
  def self.anchor=(value)
    @anchor = value
  end

  def size
    @size ||= self.class.size || V[]
  end
  attr_writer :size

  def anchor
    @anchor ||= self.class.anchor || V[]
  end
  attr_writer :anchor

  def thing
    @thing ||= Thing.new
  end
  def thing=(val)
    @thing = val
    @thing.look = self unless @thing.look == self
  end

  def render; end

  private

  def screen
    thing.game.context.screen
  end
end

end