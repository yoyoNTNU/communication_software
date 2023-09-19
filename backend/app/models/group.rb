class Group < ApplicationRecord
	validates :name, presence: true
  after_create :create_chatroom
  after_destroy :destroy_chatroom
	mount_uploader :photo , GroupPhotoUploader
	mount_uploader :background , GroupBackUploader

  private
  def create_chatroom 
    c=Chatroom.create(type_:"group",type_id:id)
  end

  def destroy_chatroom
    c=Chatroom.find_by(type_:"group",type_id:id)
    c.destroy if c
  end
	
end
