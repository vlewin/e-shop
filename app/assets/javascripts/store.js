$(function() {
  $("#product_search input").on('keyup', function(){
    var $form = $(this);
    setTimeout(function(){
      $form.submit()
    }, 1000)
  });

  $( "body" ).on( "click", ".quantity-helper button", function() {
    var $input = $(this).parents('.quantity-helper').find('input');
    var quantity = parseInt($input.val())

    if($(this).hasClass('quantity_minus')) {
      quantity = (quantity == 0 || quantity == 1) ? 1 : quantity-1
    } else {
      quantity = (quantity+1 > $input.data('max')) ? quantity  : quantity+1
    }

    $input.val(quantity)
  });
});
