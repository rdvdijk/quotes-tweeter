module Quotes
  class Tweeter

    def initialize(config_file = "config.yml")
      pathname = Pathname.new(config_file)
      settings = YAML::load_file(pathname.realpath)
      settings["general"]["folder"] = "#{pathname.dirname.realdirpath}"

      @database = Quotes::Database.new(settings["general"])

      setup_twitter(settings["twitter"])
      setup_facebook(settings["facebook"])
    end

    def tweet
      quote = @database.next
      Twitter.update(quote)
      @facebook.feed!(:message => quote)
    end

    private

    # see README
    def setup_twitter(settings)
      Twitter.configure do |config|
        config.consumer_key       = settings["consumer_key"]
        config.consumer_secret    = settings["consumer_secret"]
        config.oauth_token        = settings["oauth_token"]
        config.oauth_token_secret = settings["oauth_token_secret"]
      end
    end

    # see README
    def setup_facebook(settings)
      @facebook = FbGraph2::User.me(settings["access_token"])
    end

  end
end
