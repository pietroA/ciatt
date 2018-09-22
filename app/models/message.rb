class Message < ApplicationRecord
  include ActionView::Helpers::DateHelper
  
  belongs_to :chat
  belongs_to :user
  
  def time_ago
    time_ago_in_words(self.created_at)
  end
  
  def as_json(options = {})
    #include both relational tables and methods results
    super(options.merge(include:[:user]).merge(methods:[:time_ago]))
  end
end
