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

  def sent_feedback_email(user,type_,content,time)
    @resource=user
    @type_=type_
    @content=content
    @time=time
    mail(to: "yoyo102102102@gmail.com", subject: "【Express Message】回饋 - 來自 #{user.name} (#{user.email})")
  end
end
