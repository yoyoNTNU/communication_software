class Group < ApplicationRecord
	validates :name, presence: true
  after_create :create_chatroom
  before_destroy :remove_cloud_img
  after_destroy :destroy_chatroom
	mount_uploader :photo , GroupPhotoUploader
	mount_uploader :background , GroupBackUploader

  private
  def create_chatroom 
    c=Chatroom.create(type_:"group",type_id:id)
  end

  def remove_cloud_img
    if self.background.url.nil?
      self.remove_background! 
      self.save
    end
    if self.photo.url.nil?
      self.remove_photo! 
      self.save
    end
  end

  def destroy_chatroom
    c=Chatroom.find_by(type_:"group",type_id:id)
    c.destroy if c
  end
	
end
