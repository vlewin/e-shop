$(function() {
  $('#bill_to_shipping').on('click', function(e) {
    if($(this).is(":checked")) {
      $('#billing_addresses').find('input[type=radio]').attr( 'disabled', true);
    } else {
      $('#billing_addresses').find('input[type=radio]').attr( 'disabled', false);
    }

    $('#billing_addresses').toggleClass('hidden')
  })

  $('#shipping_addresses input[type=radio]').on('change', function(e) {
    if(!$('#bill_to_shipping').is(":checked")) {
      var $container = $('#billing_addresses');
      var $current_shipping = $('#shipping_addresses').find('input[type=radio]:checked')
      var $current_billing = $container.find('input[value=' + $current_shipping.val() + ']')

      // Reset disabled and text-decoration attributes
      $container.find('input[type=radio]:disabled').attr( 'disabled', false);
      $container.find('div.radio').css('text-decoration', 'none');

      $current_billing.attr( 'disabled', true);
      $current_billing.attr( 'checked', false);
      $current_billing.parents('div.radio').css('text-decoration', 'line-through');

      // Check first radio button from the list of available billing addresses
      $container.find('input:not(:disabled)').first().prop("checked", true);
    }
  })

  $('#shipping input[type=radio]').on('change', function(e) {
    var url = $('#shipping').data('endpoint');
    var shipment_id = $(this).val();

    $.ajax({
      url: url,
      method: 'PUT',
      data: { shipment_id: shipment_id },

      success: function(data) {
        $('#summary').parent().html(data)
      },
      error: function() {
        $('#summary').parent().html(data)
      }
    })
  })

  $('#update_status label').on('click', function(e) {
    var target = $(this).data('target');
    $(target).attr( 'checked', true);
    $(this).parents('form').submit();
  })
})
