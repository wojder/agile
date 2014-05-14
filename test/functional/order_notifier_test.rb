require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["paulwojdera@gmail.com"], mail.from
    assert_match /1 x Boat Rados 290/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["paulwojdera@gmail.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>Boat Rados 290<\/td>/,
      mail.body.encoded
  end

end