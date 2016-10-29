module ApplicationHelper
  def qrcode_tag(text, option = {})
    ::RQRCode::QRCode.new(text).as_svg(option).html_safe
  end

  def seat_is(number)
    [
      ["Room:A", "Seat:S1"],
      ["Room:A", "Seat:S2"],
      ["Room:A", "Seat:S3"],
      ["Room:A", "Seat:A1"],
      ["Room:A", "Seat:A2"],
      ["Room:B", "Seat:S1"],
      ["Room:B", "Seat:S2"],
      ["Room:B", "Seat:S3"],
      ["Room:B", "Seat:A1"],
      ["Room:B", "Seat:A2"]
    ][number]
  end

  def room_is(number)
    number/10*10+1
  end

  def code_is(url)
    url[0..5]
  end

  def time_is(regist_time, attr_time)
    regist_time > attr_time.beginning_of_day
  end

  def how_much(seat, regist_time, attr_time)
    price = 200
    if seat_is(seat)[1][-2] == 'S'
      price += 100
    end
    if !regist_time.nil? && regist_time > attr_time.beginning_of_day
      price += 100
    end
    price
  end

  def host_name
    if ENV['G_HOST_NAME'].present?
      ENV['G_HOST_NAME']
    else
      'localhost:3000'
    end
  end
end
