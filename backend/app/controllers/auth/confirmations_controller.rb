class Auth::ConfirmationsController < DeviseTokenAuth::ConfirmationsController

  def show
    @resource = resource_class.confirm_by_token(params[:confirmation_token])
    if @resource.errors.empty?
      @username = "尊敬的"+current_member.name
      @message = "您的 Express Message 帳號已成功啟用。"
    else
      @username = "尊敬的用戶"
      @message = "您的帳號啟用失敗，詳情請洽管理員。"
    end
  end
end
