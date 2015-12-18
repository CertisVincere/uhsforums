class Post < ActiveRecord::Base
  has_attached_file :file

  belongs_to :user
  belongs_to :topic
  belongs_to :group

  default_scope -> { order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true
  validates_with AttachmentSizeValidator, attributes: :file, less_than: 3.megabytes


end
