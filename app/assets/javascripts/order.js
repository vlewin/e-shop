$(function() {
  $('.wizard a').click(function (e) {
    e.preventDefault()
    $(this).parents('div').find('a').removeClass('active')
    $(this).addClass('active')
    $(this).tab('show')
  })

  $('#order a.btn-next').click(function (e) {
    e.preventDefault()
    $('.wizard a').removeClass('active')
    $('.wizard').find('[href^=' + $(this).attr('href') + ']').addClass('active')
  })

  $('#order a.btn-back').click(function (e) {
    e.preventDefault()
    $('.wizard a').removeClass('active')
    $('.wizard').find('[href^=' + $(this).attr('href') + ']').addClass('active')
  })
})
