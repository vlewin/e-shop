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
  $("#product_search input").on('keyup', 300, function(event){
    event.preventDefault()
    var $form = $(this);


    // setTimeout(function(){
    delay(function(){
      $form.submit()
    }, 500);
    // }, 2000)

    return false;
  });

  // Alphabet
  $(document).on('change', '#limit', function() {
    $(this).parents('form').submit()
  })

  // Alphabet
  $(document).on('click', '#alphabet > a', function() {
    $('#alphabet a').removeClass('active')
    $(this).addClass('active')
  })
});
