$ ->
  $room_a = $('#seat-1, #seat-2, #seat-3, #seat-4, #seat-5')
  $room_b = $('#seat-6, #seat-7, #seat-8, #seat-9, #seat-10')
  $room_b.hide()
  $a = $('#btn-a')
  $b = $('#btn-b')
  clicked =
    'background-color':'#f8b500'
    'color':'white'
  click =
    'background-color':'white'
    'color':'#666666'

  $a.click ->
    $room_b.hide()
    $room_a.fadeIn(500)
    $a.css(clicked)
    $b.css(click)
  $b.click ->
    $room_a.hide()
    $room_b.fadeIn(500)
    $b.css(clicked)
    $a.css(click)
#####################################################
  date29 = []
  date30 = []
  for i in [1..25]
    date29.push ".time-#{i}"
    date30.push ".time-#{i+25}"
  $date29 = $(date29.join(", "))
  $date30 = $(date30.join(", "))

  $date30.hide()
