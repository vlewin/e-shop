$(function() {
  $('.progress-steps a').add('a.btn-next').click(function (e) {
    var $completion = $('ul.progress-timeline-completion')
    var step = $(this).data('step');
    $completion.attr('step', step);
    $($completion.find('li.step')[parseInt(step)-1]).addClass('active')
  })

  $('a.btn-back').click(function (e) {
    var $completion = $('ul.progress-timeline-completion')
    var step = $(this).data('step');
    $completion.attr('step', step);
    $($completion.find('li.step')[parseInt(step)]).removeClass('active')
  })
})
