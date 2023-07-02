class Message < ApplicationRecord
    validates :type, presence: true
    validate  :check_message_exist
    belongs_to :member
    belongs_to :chatroom


    def check_message_exist
        if type=="string" && content.blank?
            errors.add(:content, "message is blank") 
        end
        if type=="photo" && photo.blank?
            errors.add(:photo, "message is blank") 
        end
    end
end
