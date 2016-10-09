module ApplicationHelper
  def qrcode_tag(text, option = {})
    ::RQRCode::QRCode.new(text).as_svg(option).html_safe
  end

  def seat_is(number)
    3
  end
end
