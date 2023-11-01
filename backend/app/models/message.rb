class Message < ApplicationRecord
    validates :type_, presence: true
    validate  :check_message_exist
    before_destroy :set_foreign_key_null
    before_destroy :remove_cloud_file
    after_create :set_message_type
    belongs_to :member
    belongs_to :chatroom
    belongs_to :reply_to, class_name: 'Message', optional: true 
    has_many :message_readers, dependent: :destroy
    mount_uploader :file , MessageUploader


    private
    def check_message_exist
      if type_=="string" || type_=="info" || type_== "call" || type_== "view"
        if content.blank?
          errors.add(:content, "message is blank") 
        end
      else 
        if file.blank?
          errors.add(:file, "message is blank") 
        end
      end
    end

    def set_foreign_key_null
      Message.where(reply_to_id:id).update_all(reply_to_id:nil)
    end

    def remove_cloud_file
      if self.file.url.nil?
        self.remove_file! 
        self.save
      end
    end

    def set_message_type
      if !file.nil? && !file.url.nil?
        temp=file.url.split(".").last.downcase
        if temp=="jpg" || temp=="jpeg" || temp=="png" || temp=="gif"
          self.type_="photo"
        elsif temp=="mp4" || temp=="mov"
          self.type_="video"
        elsif temp=="mp3" || temp=="wav"
          self.type_="voice"
        else
          self.type_="file"
        end
        self.save
      end
    end
end
