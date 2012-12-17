/**
 * Update the merge banners to display "automagically" instead of "automatically"
 */

$(function boostrap() {
  'use strict';

  $('.merge-pr .mergeable. p.message').each(function each() {
    var message = $(this);

    message.text(
      message.text().replace('automatically merged', 'merged automagically')
    );
  });

  // dshaw-ify the github unicorn
  if (~$('title').html().toLowerCase().indexOf('unicorn')) {
    $('.container p img').css('-webkit-transform', 'scaleX(-1)');
  }
});
