$(function() {
  // Categories
  $('body').on('click', '#categories li>a', function() {
    $('#categories li').removeClass('active')
    $(this).parent().addClass('active')
  })

  // Search
  $("#product_search input").on('keyup', function(){
    var $form = $(this);
    setTimeout(function(){
      $form.submit()
    }, 1000)
  });
});
