class StaticPagesController < ApplicationController

  def about_us
  end

  def contact_us
  end
  
  def news
  	@dcc_news_feed = Feedzirra::Feed.fetch_and_parse("http://www.dcc.ac.uk/news/dmponline-0/feed")
  end
end