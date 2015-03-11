//= require jquery
//= require jquery_ujs

// INFO: https://github.com/metaskills/less-rails-bootstrap/tree/master/app/assets/javascripts/twitter/bootstrap
//= require twitter/bootstrap/collapse
//= require twitter/bootstrap/dropdown
//= require twitter/bootstrap/alert
//= require twitter/bootstrap/modal
//= require twitter/bootstrap/tooltip
//= require_tree

// Boostrap tootip
$(document).tooltip({
  selector: '[rel="tooltip"], [data-toggle="tooltip"]',
  container: 'body'
});

// Hide flash message
$(document).ready(function() {
  setTimeout(function(){
    $('#rails_flash').fadeOut('slow')
  }, 2000)
});

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
