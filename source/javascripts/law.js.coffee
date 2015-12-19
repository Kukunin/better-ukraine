$ ->
  $('.important').parents('.chapter, .section').addClass('has-important')

  $('.section h4')
    .append($('<span>', class: 'expand-knob'))
    .on 'click', '.expand-knob', () -> $(this).parents('.section').toggleClass('expanded')

  $('#details-level input').change () ->
    $('.law')[$(this).val()]('only-important')
