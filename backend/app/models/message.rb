class Message < ApplicationRecord
    validates :type_, presence: true
    validate  :check_message_exist
    belongs_to :member
    belongs_to :chatroom
    belongs_to :reply_to, class_name: 'Message', optional: true
    mount_uploader :photo , MessageUploader

    def check_message_exist
        if type_=="string" && content.blank?
            errors.add(:content, "message is blank") 
        end
        if type_=="photo" && photo.blank?
            errors.add(:photo, "message is blank") 
        end
    end
end
