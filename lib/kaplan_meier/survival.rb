require "kaplan_meier/version"

module KaplanMeier
  class Survival

    def initialize
      @data = {}
    end

    def add(time, event_count = 1, censored_count = 0)
      leaf = @data[time]
      if leaf.nil?
        @data[time] = KaplanMeierCoord.new(time, event_count, censored_count)
      else
        leaf.add_count(event_count: event_count, censored_count: censored_count)
      end
    end

    def initial_at_risk_count
      self.to_a.length
    end

    def time_periods
      @data.keys.sort
    end

    def to_a
      @data.keys.sort.map do |k|
        @data[k].to_a
      end.flatten
    end

    def raw_probabilities(as_percent: false)
      return [] if @data.keys.length < 1
      self.probabilities.map {|i| as_percent ? (i[:probability] * 100.0).round(2) : i[:probability]}
    end

    def probabilities(as_percent: false)
      return [] if @data.keys.length < 1
      result = [{time: 0, probability: 1.0}]
      time_points = self.to_a
      n = time_points.length
      percent = 1.0
      (0...n).each do |i|
        percent = (1.0 - (time_points[i][:event].to_f / (n - i))) * percent.to_f
        result << {time: time_points[i][:time_point], probability: as_percent ? (percent * 100.0).round(2) : percent}
      end
      result
    end

    def range(start_time: 0, end_time: nil)
      (start_time..(end_time || time_periods[-1])).to_a
    end

    def values_for_range(start_time: 0, end_time: nil, as_percent: false)
      return [] if @data.keys.length < 1
      result = []
      range_array = range(start_time: start_time, end_time: end_time)
      periods = probabilities(as_percent: as_percent)
      current_period = periods.shift
      range_value = range_array.shift
      until range_value.nil?
        if periods[0] && range_value >= periods[0][:time]
          current_period = periods.shift
          next
        end
        result << current_period[:probability]
        range_value = range_array.shift
      end
      result
    end

  end
end

class KaplanMeierCoord
  def initialize(time_point, event_count = 1, censored_count = 0)
    @time_point = time_point
    @event_count = event_count
    @censored_count = censored_count
  end

  def add_event_count(event_count)
    @event_count += event_count
  end

  def add_censored_count(censored_count)
    @censored_count += censored_count
  end

  def add_count(event_count: 0, censored_count: 0)
    add_event_count(event_count)
    add_censored_count(censored_count)
  end

  def to_s
    "@#{@time_point}: #{@event_count} event(s). #{@censored_count} censored."
  end

  def to_a
    result = []
    @event_count.times do
      result << {time_point: @time_point, event: 1}
    end
    @censored_count.times do
      result << {time_point: @time_point, event: 0}
    end
    result
  end
end