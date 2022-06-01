require_relative './lib/logfile'

parser = Logfile.new(ARGV[0])
parser.parse

parser.most_views
parser.most_unique_views
parser.print_output

