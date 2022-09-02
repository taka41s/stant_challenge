class HardJob < ActiveJob::Base
  queue_as :default

  def perform(document)
    path = "./handlefile/#{self.job_id}.txt"
    file = File.new(path, "w")
    file.puts(document)
    file.close

    parsed_elements = Parser.new(archive_path: file).make
    json_elements_converted = []

    parsed_elements[:track_a].map{|x| x}.each do |palestra|
      @palestra = Palestra.new(palestra)
      @palestra.track = "Track A"
      @palestra.save
    end

    parsed_elements[:track_b].map{|x| x}.each do |palestra|
      @palestra = Palestra.new(palestra)
      @palestra.track = "Track B"
      @palestra.save
    end

    parsed_elements.each do |parsed|
      json_elements_converted << parsed.to_json
    end
  end
end
