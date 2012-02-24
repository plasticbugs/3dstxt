class Comment < ActiveRecord::Base
  belongs_to :message
  belongs_to :user

  validates_presence_of :content, :author, :author_email
  validates_length_of :content,
                      :minimum => 1,
                      :maximum => 3000
end
