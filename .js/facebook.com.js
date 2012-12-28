$(function ready() {
  "use strict";

  setInterval(function interval() {
    // Remove those awfull ads from the sidebar
    $('span[class^="ads"]').parents('.ego_section').remove();

    // Remove ad crap from the timeline
    $('span.uiStreamAdditionalLogging').each(function each() {
      var span = $(this);
      if (!~span.text().toLowerCase().indexOf('sponsored')) return;

      // Remove the whole damn post block
      span.parents('li.uiUnifiedStory.uiStreamStory.genericStreamStory').remove();
    });
  }, 1000);
});
