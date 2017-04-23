function renderGadget(containerSelector, options) {
  var frameId = _.uniqueId("exmodal");
  $(containerSelector).append('<a href="#' + frameId + '" onclick="setGadgetUrl(\'#' + frameId +
    '\')" rel="modal:open">' + (options.label || 'Gadget') + '</a>');


  if (options.task) {
    $(containerSelector).append(
      '<iframe id="' + frameId + '" style="display:none;" data-src="../test.html?cypherSetup=' + options.cypherSetup +'&cypherTaskJSON=' +
      formatTaskJSON(options.task) +
      '" width="750" height="850" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>');
  }
  else if (options.taskName) {
    $(containerSelector).append(
      '<iframe id="' + frameId + '" style="display:none;" data-src="../test.html?cypherSetup=' + options.cypherSetup + '&cypherTask=' +
      options.taskName +
      '" width="750" height="850" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>');
  }

  function formatTaskJSON(task) {
    return encodeURIComponent(JSON.stringify(task));
  }
}

function setGadgetUrl(sel) {
  var $iframe = $(sel);
  $iframe.attr("src", $iframe.data("src"));
}
