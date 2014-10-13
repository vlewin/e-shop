$(function() {
  $( "body" ).on( "click", "#items form button", function() {
    var $form = $($(this).parents('form'));
    setTimeout(function(){
      $form.submit()
    }, 500)
  });

  $( "body" ).on( "keyup", "#items #quantity", function() {
    var $form = $($(this).parents('form'));
    setTimeout(function(){
      $form.submit()
    }, 500)
  });
});

