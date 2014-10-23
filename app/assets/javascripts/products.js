$(function() {
  $('#product_form a.pull-left').click(function() {
    $('#product_form a.pull-left').parents('.media').find('input[type=file]').click();
    return false;
  })
});

