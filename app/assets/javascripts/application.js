//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree

// Boostrap tootip
$(document).tooltip({
  selector: '[rel="tooltip"], [data-toggle="tooltip"]',
  container: 'body'
})

$(document).on( "click", ".quantity-helper button", function() {
  var $input = $(this).parents('.quantity-helper').find('input');
  var quantity = parseInt($input.val())

  if($(this).hasClass('quantity_minus')) {
    quantity = (quantity == 0 || quantity == 1) ? 1 : quantity-1
  } else {
    quantity = (quantity+1 > $input.data('max')) ? quantity  : quantity+1
  }

  $input.val(quantity)
  return false;
});
