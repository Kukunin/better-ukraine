import $ from 'jquery-slim';
import _ from 'bootstrap-sass';

$(() => {
  $('.important').parents('.chapter, .section').addClass('has-important');

  $('.section h4')
    .append($('<span>', {class: 'expand-knob'}))
    .on('click', '.expand-knob', function() { return $(this).parents('.section').toggleClass('expanded'); });

  $('#details-level input').change(function() {
    return $('.law')[$(this).val()]('only-important');
  });
});

