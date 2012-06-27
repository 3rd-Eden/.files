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
});
