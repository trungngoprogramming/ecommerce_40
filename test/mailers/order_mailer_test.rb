require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "status" do
    mail = OrderMailer.status
    assert_equal "Status", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
