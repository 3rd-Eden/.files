/**
 * Update the merge banners to display "automagically" instead of "automatically"
 */

$(function boostrap() {
  'use strict';

  // merge automagically
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

  // show package.json under the tree view
  var match = $('#slider .tree-browser a').filter(function () {
    return 'package.json' === $(this).text();
  });

  if (match.length) $.get(match.attr('href'), function (res) {
    var file = $(res).find('#files');

    // make it look good
    file.css({
        marginTop: -15
      , marginBottom: 15
      , display: 'none'
    });

    // append package.json title
    file.find('.info span.icon').append($('<b>package.json</b>').css({
        padding: '8px 4px'
      , display: 'inline-block'
    }));

    // add it to the dom and animate it
    $('.tree-browser-wrapper').after(file);
    file.fadeIn();
  });
});
