$(function() {
  $('.wizard a').click(function (e) {
    e.preventDefault()
    $(this).parents('div').find('a').removeClass('active')
    $(this).addClass('active')
    $(this).tab('show')
  })

  $('.new_order_form a.btn-next').click(function (e) {
    console.log('Next clicked')
    e.preventDefault()
    $('.wizard a').removeClass('active')
    $('.wizard').find('[href=' + $(this).attr('href') + ']').addClass('active')
    console.log($(this).attr('href'))
  })

  $('.new_order_form a.btn-back').click(function (e) {
    e.preventDefault()
    $('.wizard a').removeClass('active')
    $('.wizard').find('[href^=' + $(this).attr('href') + ']').addClass('active')
  })
})
