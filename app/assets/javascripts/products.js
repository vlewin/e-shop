$(function() {
  // Set EAN prefix to category id
  $('#new_product #product_category_id').change(function() {
    var $ean = $('#product_ean');
    var next_product_id = $ean.data('id');
    var prefixed_ean = $(this).val() + next_product_id;

    $('#product_ean').val(prefixed_ean);
    return false;
  })
  // Image upload
  $('#product_form a.pull-left').click(function() {
    $('#product_form a.pull-left').parents('.media').find('input[type=file]').click();
    return false;
  })
});

