class Message < ApplicationRecord
    validates :type_, presence: true
    validate  :check_message_exist
    before_destroy :set_foreign_key_null
    belongs_to :member
    belongs_to :chatroom
    belongs_to :reply_to, class_name: 'Message', optional: true 
    has_many :message_readers, dependent: :destroy
    mount_uploader :file , MessageUploader


    private
    #TODO:需要設定8種message(string,photo,video,file,call,view,info,voice)
    def check_message_exist
        if type_=="string" && content.blank?
            errors.add(:content, "message is blank") 
        end
        if type_=="photo" && file.blank?
            errors.add(:file, "message is blank") 
        end
    end

    def set_foreign_key_null
      p 123
      Message.where(reply_to_id:id).update_all(reply_to_id:nil)
    end
end
