class Topic < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :group
  belongs_to :user
  has_many :posts, :dependent => :destroy

  validates :name, presence: true, length: { maximum: 20 }
end
