class Logfile

  attr_reader :path, :parsed_data

  def initialize(path)
    @path = path
    @parsed_data = []
  end

  def parse
    raise "Please check file, no file exists on this path" unless File.exists? @path

    @parsed_data = File.read(@path).split("\n").map(&:split)
  end

  def most_views
    @most_views ||= @parsed_data.group_by(&:first).map { |page, ip| [page, ip.inject(0) { |sum| sum + 1 }] }.sort_by(&:last).reverse.to_h 
  end

  def most_unique_views
    webpages_array_count = @parsed_data.sort_by(&:first).group_by { |e| e }.map { |k, v| [k.first] }
    @most_unique_views ||= webpages_array_count.flatten.group_by { |e| e }.map { |k, v| [k, v.length] }.sort_by(&:last).reverse.to_h
  end

  def print_output
    puts "Most viewed pages:"
    @most_views.each { |webpage, count| 
      puts "#{webpage} ~ #{count} views"
    }
                                                
    puts "\n"
                                                
    puts "Most unique views per page:"
    @most_unique_views.each { |webpage, count| 
      puts "#{webpage} ~ #{count} unique views"
    }
  end
end
