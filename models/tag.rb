class Tag < ActiveRecord::Base
  belongs_to :tweet, touch: true
end
