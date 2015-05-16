module GreatGazoo
  class TimeWarp
    def initialize(options = {})
      @options = default_options.merge(options)

      @start_hour, @start_minute = @options[:start_time].split(/:/).map { |i| i.to_i }
      @end_hour, @end_minute = @options[:end_time].split(/:/).map { |i| i.to_i }

      @time_method = @options[:time_method]
      @time_set_method = "#{@options[:time_method].to_s}="
    end

    def bend(sequence)
      sequence.each do |object|
        current_time = object.send(@time_method)
        if blacked_out?(current_time)
          new_time = Time.new(current_time.year, current_time.month, current_time.day, current_time.hour + (@end_hour - @start_hour), current_time.min)
          object.send(@time_set_method, new_time)
        end
      end
    end

    private

    def blacked_out?(time)
      after_blackout_start?(time) && before_blackout_end?(time)
    end

    def after_blackout_start?(time)
      time.hour > @start_hour || (time.hour == @start_hour && time.min >= @start_minute)
    end

    def before_blackout_end?(time)
      time.hour < @end_hour || (time.hour == @end_hour && time.min <= @end_minute)
    end

    def default_options
      {
        time_method:  :time,
        start_time:   '8:00',
        end_time:     '17:00',
      }
    end
  end
end
