/**
 * Update the merge banners to display "automagically" instead of "automatically"
 */

$(function boostrap() {
  'use strict';

  //
  // For fun and giggles, replace the automatically with autoMAGICALLY.
  //
  $('.merge-pr .mergeable. p.message').each(function each() {
    var message = $(this);

    message.text(
      message.text().replace('automatically merged', 'merged automagically')
    );
  });

  //
  // When a 500 error occures, dshaw-fy the unicorn.
  //
  if (~$('title').html().toLowerCase().indexOf('unicorn')) {
    $('.container p img').css('-webkit-transform', 'scaleX(-1)');
  }

  //
  // Add the package.json as preview to the page when viewing Node.js
  // dependencies.
  //
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

  //
  // Github doesn't support ?w=1 for pull requests, this fixes it
  //
  if (/\/files\?w\=1/.test(window.location.href)) {
    $('div.meta', '#files').each(function () {
      var meta = $(this)
        , filename = meta.data('path');

      // fetch the sha
      var href = meta.find('.button-group a')[0].href
        , base = href.slice(0, href.indexOf('/blob/'))
        , sha = /blob\/([^]+?)\//g.exec(href)[1];

      $.get(base +'/commit/'+ sha + '?w=1', function (res) {
        var wmeta = $('#files div.meta[data-path="'+ filename +'"]', res);

        // Replace the diff with with the cleaned file
        meta.parent().replaceWith(wmeta.parent());
      });
    });
  }
});
