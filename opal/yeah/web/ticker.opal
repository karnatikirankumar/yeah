module Yeah
module Web
class Ticker
  attr_accessor :rate
  attr_reader :tick_count, :ticks_per_second

  def initialize(args = {})
    @rate = args.fetch(:rate, DEFAULT_TICKER_RATE)
    @tick_count = 0
    @ticks_per_second = 0
    @next_tps = 0
  end

  def on_tick(&block)
    %x{
      var lastTime = new Date().getTime(),
          lastMeasureTime = lastTime,
          elapsed = 0,
          interval,
          currentTime;

      var loop = function() {
        interval = 1.0 / #{@rate};
        currentTime = new Date().getTime();
        elapsed = (currentTime - lastTime) / 1000.0;

        if (elapsed > interval) {
          // TODO: add to ticks before yielding
          #{yield `elapsed`}

          #@tick_count += 1;
          #@next_tps += 1;

          lastTime = currentTime - (elapsed % interval);
        }

        if (currentTime - lastMeasureTime > 1000) {
          #@ticks_per_second = #@next_tps;
          #@next_tps = 0;

          lastMeasureTime = currentTime - (currentTime - lastMeasureTime) % 1000;
        }

        window.requestAnimationFrame(loop);
      };

      window.requestAnimationFrame(loop);
    }
  end
end
end
end
