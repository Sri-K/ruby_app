class LogParser
  def initialize(logfile)
    @logfile = logfile

    raise "File not found" if logfile.length.zero?
    raise "File or the directory not exists: #{logfile}" unless File.exist?(logfile)
  end

  def parse
  end
end

if ARGV[0]
  logfile_parser = LogParser.new(ARGV[0])
  logfile_parser.parse
end