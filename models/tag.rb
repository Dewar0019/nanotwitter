class Tag < ActiveRecord::Base
  belongs_to :tweet, touch: true

  #extract a list of hashtags in the string without the preceding #
  def self.extract_hashtags(text)
  	return [] unless text =~ /[#＃]/
  	text.scan(/#\S+/).each{|tag| tag.slice!(0)} 
  end

end
