$(function() {
  $("#product_search input").on('keyup', function(){
    var $form = $(this);
    setTimeout(function(){
      console.log('Fire AJAX call')
      $form.submit()
    }, 1000)
  });
});
