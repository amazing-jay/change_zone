require "change_zone/version"

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Time #:nodoc:
      module ZoneCalculations
        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method_chain :change, :zone
          end
        end

        def change_zone(new_zone)
          new_zone = ::Time.__send__(:get_zone, new_zone)
          return self if new_zone.name == zone
          new_zone.local(year,month,day,hour,min,sec,usec)
        end

        def change_with_zone(options)
          result = change_without_zone(options)
          options[:zone] ? result.change_zone(options[:zone]) : result
        end

      end
    end
  end
  class TimeWithZone
    # rails implementation of change_zone falls to method_missing, which invokes Time::__send__ :change_zone,
    # and then wraps the result in a new TimeWithZone object with the current = old zone, effectively undoing the change
    def change_zone(new_zone)
      time.change_zone(new_zone)
    end

    # rails implementation of change falls to method_missing, which invokes Time::__send__ :change,
    # and then wraps the result in a new TimeWithZone object with the current = old zone, effectively undoing the change
    # when the zone option is passed
    def change(options)
      if options[:zone]
        time.change(options)
      else
        result = time.change(options)
        result.acts_like?(:time) ? self.class.new(nil, time_zone, result) : result
      end
    end
  end
end

class Time
  include ActiveSupport::CoreExtensions::Time::ZoneCalculations

  def to_datetime
    # Convert seconds + microseconds into a fractional number of seconds
    seconds = sec + Rational(usec, 10**6)

    # Convert a UTC offset measured in minutes to one measured in a
    # fraction of a day.
    offset = Rational(utc_offset, 60 * 60 * 24)
    DateTime.new(year, month, day, hour, min, seconds, offset)
  end
end
