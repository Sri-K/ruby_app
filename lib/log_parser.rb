class LogParser
  def initialize(logfile)
    @logfile = logfile

    raise "File not found: #{logfile}" unless File.exist?(logfile)
  end
end