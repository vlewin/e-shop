$(function() {
  $('.progress-steps a').click(function (e) {
    var $completion = $('ul.progress-timeline-completion')
    $completion.attr('step', $(this).data('step'));

    var $steps = $completion.find('li.step').removeClass('active')
    var steps = $.makeArray($steps)
    var parent = $(this).parents('li')[0]

    for (i = 0; i <= steps.indexOf(parent); i++) {
      $(steps[i]).addClass('active')
    }
  })

  $('a.btn-next').click(function (e) {
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
