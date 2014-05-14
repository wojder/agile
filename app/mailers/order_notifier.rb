class OrderNotifier < ActionMailer::Base
  default from: 'Paul <paulwojdera@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  # en.order_notifier.received.subject
  #
  def received(order)
    @order = order

 mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
   end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  # en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order

    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end

  def error_occured(error)
    @error = error
    mail :to => "paulwojdera@gmail.com", :subject => 'Boat shop error Incident'
  end
end