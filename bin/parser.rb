require './lib/log_parser'

filepath = ARGV.first

if filepath
  logfile_parser = LogParser.new(filepath)
  logfile_parser.parse_logfile

  puts
  puts "Most page views"
  puts "#{logfile_parser.print_most_views}"

  puts
  puts "Most Unique page views"
  puts "#{logfile_parser.print_unique_views}"
  puts
end