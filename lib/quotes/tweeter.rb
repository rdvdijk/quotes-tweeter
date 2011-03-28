module Quotes
  class Tweeter
    def initialize(config_file = "config.yml")
      pn = Pathname.new(config_file)
      settings = YAML::load_file(pn.realpath)
      settings["general"]["folder"] = "#{pn.dirname.realdirpath}"
      @database = Quotes::Database.new(settings["general"])
      setup_twitter(settings["twitter"])
    end
    
    def tweet
      quote = @database.next

      puts quote
      #Twitter.update(quote)
    end
    
    private
    
    # https://dev.twitter.com/apps
    def setup_twitter(settings)
      Twitter.configure do |config|
        config.consumer_key       = settings["consumer_key"]
        config.consumer_secret    = settings["consumer_secret"]
        config.oauth_token        = settings["oauth_token"]
        config.oauth_token_secret = settings["oauth_token_secret"]
      end
    end
  end
end