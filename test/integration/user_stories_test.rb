require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixture :products

  # test "the truth" do
  #   assert true
  # end
test "buying a product" do
  LineItem.delete_all
  Order.delete_all
  ruby_book = products(:ruby)

  get "/"
  assert_response :success
  assert_template "index"

  xml_http_request :post, '/line_items', :product_id => ruby_book.id
  assert_response :success

  cart = Cart.find(session[:cart_id])
  assert_equal 1, cart.line_items.size
  assert_equal ruby_book, cart.line_items[0].product

  get "/orders/new"
  assert_response :success
  assert_template "new"

  post_via_redirect "/orders"
  					:order => { :name => "Paul Wojdera",
  								:address => "Pomorska 150",
  								:email => "paulwojdera@fmail.dod",
  								:pay_type => "Cash"  }
  assert_response :success
  assert_template "index"
  cart = Cart.find(session[:cart_id])
  assert_equal 0, cart.line_items.size

  orders = Order.find(:all)
  assert_equal 1, orders_size
  order = order[0

  assert_equal "Paul Wojdera",	order.name
  assert_equal "Pomorska 150",	order.address
  assert_equal "paulwojdera@fmail.dod", order.email
  assert_equal "Cash"			order.pay_type

  assert_equal 1, order.line_items.size
  line_item = order.line_items.size
  assert_equal ruby_book, line_item.product

  mail = ActionMailer::Base.deliveries.last
  assert_equal["paulwojdera@fmail.dod"], mail.to
  assert_equal 'Paul Wojdera <paulwojdera@fmail.dod>', mail[:from].value
  assert_equal "Pragmatic Store Order Confirmation", mail.subject

  end
  test "should mail the admin when error occurs" do
    get "/carts/wibble"
    assert_response :redirect 
    assert_template "/"

    mail = ActionMailer::Base.deliveries.last
    assert_equal ["paulwojdera@gmail.com"], mail.to
    assert_equal "some one <depot@exapmle.com>", mail[:from].value
    assert_equal "Depot App Error Incident", mail.subject
  end
end
