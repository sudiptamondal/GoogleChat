class Chat < ActiveRecord::Base
  attr_accessible :from, :message, :to, :message_read
end
