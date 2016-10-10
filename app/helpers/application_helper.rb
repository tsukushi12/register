module ApplicationHelper
  def qrcode_tag(text, option = {})
    ::RQRCode::QRCode.new(text).as_svg(option).html_safe
  end

  def seat_is(number)
    [
      ["Room:A", "Seat:S1"],
      ["Room:A", "Seat:S2"],
      ["Room:A", "Seat:A1"],
      ["Room:A", "Seat:A2"],
      ["Room:A", "Seat:A3"],
      ["Room:B", "Seat:S1"],
      ["Room:B", "Seat:S2"],
      ["Room:B", "Seat:A1"],
      ["Room:B", "Seat:A2"],
      ["Room:B", "Seat:A3"]
    ][number]
  end
  
  def room_is(number)
    number/10*10+1
  end
end
