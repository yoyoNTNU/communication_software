class Api::MessageController < ApplicationController
  before_action :authenticate_member!

  def sent_message


  end

  def sent_photo

  end

  def revoke

  end

  def transfer

  end

  def tag

  end

  def reply

  end

  def index
    
  end

  private

  def message_params
    params.permit(:type_, :content, :photo, :isPinned, :reply_to_id)
  end

end
