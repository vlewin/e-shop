class UserMailer < ActionMailer::Base
  default from: "e-shop-demo-eu@example.com"

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(to: user.email, subject: 'Order has been received', template_path: 'mailers', template_name: 'order_confirmation')
  end
end
