$(function() {
  $('#bill_to_shipping').on('click', function(e) {
    check_and_disable()
    $('#billing_addresses').toggleClass('hidden')
  })

  $('#shipping_addresses input[type=radio]:not(:disabled)').on('change', function(e) {
    check_and_disable()
  })

  function check_and_disable() {
    var checked = $('#shipping_addresses').find('input[type=radio]:checked')

    // Enable all radio buttons
    $('#billing_addresses').find('input[type=radio]').attr( 'disabled', false);
    // $('#billing_addresses').find('input[type=radio]').removeAttr( 'checked');


    // Disable selected shipping address
    $('#billing_addresses').find('input[value=' + checked.val() + ']').attr( 'disabled', true);

    // Check first not disabled radio button from the list
    var radios = $('#billing_addresses').find('input:not(:disabled)')
    if(radios.length > 1) {
      radios[0].attr( 'checked', true);
      // radios[0].click();
      radios[0].click();
    } else {
      radios.attr( 'checked', true);
      // radios.click();
      radios.click();
    }
  }

})