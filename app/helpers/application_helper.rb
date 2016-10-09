module ApplicationHelper
  def qrcode_tag(text, option = {})
    ::RQRCode::QRCode.new(text).as_svg(option).html_safe
  end

  def seat_is(number)
    [
      [:roomA, "S1"],
      [:roomA, "S2"],
      [:roomA, "A1"],
      [:roomA, "A2"],
      [:roomA, "A3"],
      [:roomB, "S1"],
      [:roomB, "S2"],
      [:roomB, "A1"],
      [:roomB, "A2"],
      [:roomB, "A3"]
    ][number]
  end
end
