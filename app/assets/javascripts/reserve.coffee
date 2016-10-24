$ ->
  clicked =
    'background-color':'#f8b500'
    'color':'white'
  click =
    'background-color':'white'
    'color':'#666666'
#################################
  $room_a = $('#seat-1, #seat-2, #seat-3, #seat-4, #seat-5')
  $room_b = $('#seat-6, #seat-7, #seat-8, #seat-9, #seat-10')
  seat = 0
  seat = $('p.price').data('seat-id')
  if seat < 0
    $a = $('#btn-a').css(click)
    $b = $('#btn-b').css(clicked)
    $room_a.hide()
  else
    $a = $('#btn-a').css(clicked)
    $b = $('#btn-b').css(click)
    $room_b.hide()
#################################
  date29 = []
  date30 = []
  for i in [1..25]
    date29.push "#time-#{i}"
    date30.push "#time-#{i+25}"
  $date29 = $(date29.join(", "))
  $date30 = $(date30.join(", "))
  $date30.hide()
  $29 = $('#date-29').css(clicked)
  $30 = $('#date-30').css(click)
#################################
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
#################################
  $29.click ->
    $date30.hide()
    $date29.fadeIn(500)
    $29.css(clicked)
    $30.css(click)
  $30.click ->
    $date29.hide()
    $date30.fadeIn(500)
    $30.css(clicked)
    $29.css(click)
#################################
  $('div#help img, div#help a').hide()
  $('div#help img:first-child').fadeIn()
  $('div#help img').click ->
    if $(@).next().is('img')
      $(@).fadeOut 'fast', ->
        $(@).next('img').fadeIn()
    else if $(@).next().is('a')
      $(@).fadeOut 'fast', ->
        $(@).next('a').fadeIn()
