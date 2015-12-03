class Topic < ActiveRecord::Base
  belongs_to :group
  has_many :posts, :dependent => :destroy
end
