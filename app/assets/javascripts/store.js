$(function() {
  $("#product_search input").on('keyup', function(){
    var $form = $(this);
    setTimeout(function(){
      $form.submit()
    }, 1000)
  });

  $(".quantity-helper button").on('click', function(){
    var $input = $(this).parents('.quantity-helper').find('input');
    var quantity = parseInt($input.val())

    if($(this).hasClass('quantity_minus')) {
      quantity = quantity == 0 ? 0 : quantity-1
    } else {
      quantity = quantity+1;
    }

    $input.val(quantity)
  });
});
