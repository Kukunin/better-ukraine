$ ->
  $('.important').parents('.chapter, .section').addClass('has-important')
  $('#details-level input').change () ->
    $('.law')[$(this).val()]('only-important')
