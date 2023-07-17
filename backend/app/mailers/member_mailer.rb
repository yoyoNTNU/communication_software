class MemberMailer < ApplicationMailer
  def login_success_email(user)
    @resource = user
    mail(to: user.email, subject: '【Express Message】登入成功通知')
  end

  def login_failed_email(user)
    @resource = user
    if user
      mail(to: user.email, subject: '【Express Message】登入失敗通知')
    end
  end
end
