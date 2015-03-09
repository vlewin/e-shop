$(function() {
  $('#search-form input').on('keyup', 300, function(event){
    event.preventDefault()
    var $form = $(this);

    delay(function(){
      $form.submit()
    }, 500);

    return false;
  });

  $(document).on('ajax:complete', '#search-form', function (data, xhr, status) {
    $('.fa-spinner').removeClass('hidden');

    var target = $(this).data('target');
    var handler = $(this).data('handler');

    if(target === undefined) {
      console.warn('Please set data-target attribute on "' + $(this).text() + '" link');
    } else {
      if(handler === undefined) {
        $(target).html(xhr.responseText);
      } else {
        $(target)[handler](xhr.responseText);
      }
    }

    $('.fa-spinner').addClass('hidden')
  });

  // $(document).on('ajax:complete', 'ul.pagination', function (data, xhr, status) {
  //   $('.fa-spinner').removeClass('hidden');

  //   var target = $(this).data('target');
  //   var handler = $(this).data('handler');

  //   console.log(target)

  //   if(target === undefined) {
  //     console.warn('Please set data-target attribute on "' + $(this).text() + '" link');
  //   } else {
  //     if(handler === undefined) {
  //       $(target).html(xhr.responseText);
  //     } else {
  //       $(target)[handler](xhr.responseText);
  //     }
  //   }

  //   $('.fa-spinner').addClass('hidden')
  // });
})

