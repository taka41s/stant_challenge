class Parser
  attr_accessor :archive, :archive_path, :archive_tuples, :items

  def initialize(options = {})
      @archive_path = options[:archive_path]
      @items = []
      @durations = []
  end

  def make
    read_file
    organize_tuples
    package_schedules
  end

  def package_schedules
    package = {:track_a => schedule_a, :track_b => schedule_b}
  end

  def set_track_a
    morning_duration = 180
    events_array = items.map{|item| item}
    morning_session = []
    morning_sum = 0

    events_array.each do |event|
      morning_sum = event[:duration] + morning_sum
      morning_session << event
      break if morning_sum >= morning_duration
    end

    events_array = events_array - morning_session

    afternoon_sum = 0
    afternoon_session = []
    afternoon_duration = 240

    events_array.each do |event|

      afternoon_sum = event[:duration] + afternoon_sum
      afternoon_session << event

      if afternoon_sum > afternoon_duration
        afternoon_session.delete(afternoon_session.last)
      end

      break if afternoon_sum >= afternoon_duration
    end

    events_array = events_array - afternoon_session
    duration_sum = 0
    track_a = morning_session + [event: "Almoço", duration: 60] + afternoon_session + [event: "Evento de networking", duration: 30]
  end

  def set_track_b
    track_b = items.map{|item| item} - set_track_a
    morning_duration = 180
    morning_session = []
    morning_sum = 0 

    track_b.each do |event|
      morning_sum = event[:duration] + morning_sum
      morning_session << event

      if morning_sum > morning_duration
        morning_session.delete(morning_session.last)
      end

      break if morning_sum >= morning_duration
    end
    afternoon_session = track_b - morning_session

    track_b = morning_session + [event: "Almoço", duration: 60, schedule: "12:00"] + afternoon_session + [event: "Evento de networking", duration: 30]
  end

  def schedule_a
    schedule = Time.parse("9:00")
    track_a = []
    set_track_a.each do |event|
      case event
      when track_a.last.present? && track_a.last[:event] == "Almoço"
        back_lunch = Time.parse("13:00")
        schedule = back_lunch
        track_a << event.merge({schedule: schedule.strftime('%H:%M')})
      when track_a.last.present? && track_a.last[:schedule] == "13:00" && event[:duration] == 0
        schedule = Time.parse(track_a.last[:schedule]) + track_a.last[:duration].minutes
        track_a << event.merge({schedule: schedule.strftime('%H:%M')})
      else
        schedule = Time.parse(track_a.last[:schedule]) + track_a.last[:duration].minutes if track_a.last.present?
        track_a << event.merge({schedule: schedule.strftime('%H:%M')})
      end
    end
    track_a
  end

  def schedule_b
    schedule = Time.parse("9:00")
    track_b = []
    set_track_b.each do |event|
      case event
      when event[:event] == "Almoço"
        schedule = Time.parse("12:00")
        track_b << event.merge({schedule: schedule.strftime('%H:%M')})
      when track_b.last.present? && track_b.last[:event] == "Almoço"
        back_lunch = Time.parse("13:00")
        schedule = back_lunch
        track_b << event.merge({schedule: schedule.strftime('%H:%M')})
      else
        schedule = Time.parse(track_b.last[:schedule]) + track_b.last[:duration].minutes if track_b.last.present?
        track_b << event.merge({schedule: schedule.strftime('%H:%M')})
      end
    end
    track_b
  end

  private

  def read_file
    @archive_tuples = File.readlines(@archive_path)
  end

  def organize_tuples    
    @archive_tuples.each do |line|
      next if check_lightning_item(line)
      include_min_in_item(line,line[/(\d+)/])
    end
  end

  def check_lightning_item(line)
    return include_min_in_item(line, 5) if 'lightning'.in?(line)
    return false
  end

  def include_min_in_item(line,min)
    return true if @items << {event: line, duration: min.to_i }
  end
end