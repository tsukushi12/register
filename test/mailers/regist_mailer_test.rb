require 'test_helper'

class RegistMailerTest < ActionMailer::TestCase
  test "regist_bmail" do
    mail = RegistMailer.regist_bmail
    assert_equal "Regist bmail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "regist_amail" do
    mail = RegistMailer.regist_amail
    assert_equal "Regist amail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
