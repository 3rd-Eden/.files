/**
 * Simple helper script to skip adf.ly advertisement url's. They actually put
 * the url they are redirecting to in the pathname, so we can intercept it and
 * completely skip the advertisements.
 */

(function skip() {
  'use strict';

  var a = document.createElement('a')
    , path
    , index;

  a.href = window.location.href;
  index = a.pathname.indexOf('http');

  // if we found an index in the path name we are going to assume that this is
  // the url we want to redirect to.
  if (~index) window.location.href = a.pathname.slice(index);
})();
