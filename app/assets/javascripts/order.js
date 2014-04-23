$('#checkout').collapse({
  toggle: false
})

$('#checkout_tabs a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
})
