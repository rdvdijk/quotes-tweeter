module Quotes
  class Database
    INDEX_FILE_PREFIX = ".index"
    QUOTE_INFIX = " -- "
    MAX_TWEET_LENGTH = 140
      
    def initialize(settings)
      file = settings["file"]
      folder = settings["folder"]
      @suffix = settings["suffix"]
      srand(settings["random_seed"]) if settings["random_seed"]
      
      @quotes = read_quotes(File.expand_path(file, folder)).shuffle
      @index_file = File.expand_path("#{INDEX_FILE_PREFIX}_#{file}", folder)
      @index = read_index || 0
    end
    
    def next
      quote = @quotes[@index]
      save_index
      "#{quote} -- #{@suffix}"
    end
    
    private
    
    def read_quotes(file)
      quotes = []
      File.open(file, "r") do |file|
        file.each do |line|
          quotes << line.chomp unless line =~ /^#/
        end
      end
      check_max_length(quotes)
      quotes
    end
    
    def read_index
      File.open(@index_file, "r") do |file|
        index = file.readline.to_i
      end if File.exist?(@index_file)
    end
    
    def save_index
      File.open(@index_file, "w") do |file|
        @index = (@index + 1) % @quotes.length
        file.puts @index
      end
    end

    def check_max_length(quotes)
      max_length = MAX_TWEET_LENGTH - QUOTE_INFIX.length - @suffix.length
      longest_quote = quotes.sort_by(&:length).last
      if longest_quote.length > max_length
        puts "That quote is too long to tweet (#{longest_quote.length} > #{max_length}): "
        puts longest_quote
        exit
      end
    end
  end
end
