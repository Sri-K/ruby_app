class LogParser
  attr_reader :logfile
  attr_accessor :logs

  def initialize(logfile)
    @logfile = logfile
    @logs = Hash.new { |h, k| h[k] = [] }

    raise "File not found" if logfile.length.zero?
    raise "File or the directory not exists: #{logfile}" unless File.exist?(logfile)
  end

  def parse_logfile
    File.read(logfile).each_line do |line|
      page, ip = line.split
      @logs[page] << ip
    end
    
    @logs
  end

  def print_total_views
    generated_report = generate_report("total")
    generated_report.sort_by {|k,v| v}.reverse.to_h
  end

  def print_unique_views
    generated_report = generate_report("unique")
    generated_report.sort_by {|k,v| v}.reverse.to_h
  end

  private

  def generate_report(type)
    @logs.each_with_object({}) do |(key, value), list|
      if type == "total"
        list[key] = value.size
      elsif type == "unique"
        list[key] = value.uniq.size
      else
        list[key] = value.size
      end
    end
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