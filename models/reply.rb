class Reply < ActiveRecord::Base
  belongs_to :tweet, touch: true
  belongs_to :user, touch: true
end
