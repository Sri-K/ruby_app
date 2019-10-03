class LogParser
  attr_reader :logfile, :logs

  def initialize(logfile)
    @logfile = logfile
    @logs = Hash.new { |h, k| h[k] = [] }

    validate!
  end

  def parse_logfile
    File.read(logfile).each_line do |line|
      page, ip = line.split
      @logs[page] << ip
    end
    
    @logs
  end

  def print_total_views
    total_views = generate_report(unique: false)
    sorted_report(total_views)
  end

  def print_unique_views
    unique_views = generate_report(unique: true)
    sorted_report(unique_views)
  end

  private

  def generate_report(unique:)
    @logs.each_with_object({}) do |(key, value), list|
      list[key] = unique ? value.uniq.size : value.size
    end
  end

  def sorted_report(result_hash)
    result_hash.sort_by {|k,v| v}.reverse.to_h
  end

  def validate!
    raise "File not found" if logfile.length.zero?
    raise "File or the directory not exists: #{logfile}" unless File.exist?(logfile)
  end
end

if ARGV[0]
  logfile_parser = LogParser.new(ARGV[0])
  logfile_parser.parse_logfile

  puts
  puts "Most page views"
  puts "#{logfile_parser.print_total_views}"

  puts
  puts "Most Unique page views"
  puts "#{logfile_parser.print_unique_views}"
  puts
end