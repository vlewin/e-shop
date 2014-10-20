$(function() {
  // Categories
  $(document).on('click', '#categories li>a', function() {
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

  // Alphabet
  $(document).on('click', '#alphabet > a', function() {
    $('#alphabet a').removeClass('active')
    $(this).addClass('active')
  })
});
