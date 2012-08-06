$(function ready() {
  "use strict";

  // remove those awfull ads from the sidebar
  $('span[class^="ads"]').parents('.ego_section').remove();

  setInterval(function interval() {
    $('span.uiStreamAdditionalLogging').each(function each() {
      var span = $(this);
      if (!~span.text().toLowerCase().indexOf('sponsored')) return;

      // remove the whole damn post
      span.parents('li.uiUnifiedStory.uiStreamStory.genericStreamStory').remove();
    });
  }, 1000);
});
