$(function() {
  // Category links (desktop view)
  $(document).on('click', '#categories li>a', function() {
    $('#categories li').removeClass('active')
    $(this).parent().addClass('active')
  })

  // Category links (mobile view)
  $(document).on('click', '#store a.list-group-item', function() {
    $('a.list-group-item').removeClass('active')
    $(this).addClass('active')
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
