function renderGadget(containerSelector, options) {
  if (!options.cypherSetup) return;
  var frameId = _.uniqueId("exmodal");
  $(containerSelector).append('<button onclick="setGadgetUrl(\'#' + frameId +
    '\')" rel="modal:open" class="btn">' + (options.label || 'Gadget') + '</button>');

    $(containerSelector).append(modalWindow(frameId,options));
  }

function modalWindow(frameId, options) {
   return `<div id="${frameId}" class="modal-dialog modal fade draggable" style="display:none;text-align:center;vertical-align:middle;" >
            <iframe data-src="/online_training/cypher-gadget/test.html?cypherSetup=${options.cypherSetup}&${formatTask(options)}" width="725" height="725" frameborder="0" style="margin:5px;"
              webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
           <div>`;
}
/*
    .modal {
        width: 775px;
        height: 675px;
        padding: 10px;
        margin: 0;
    }
*/

function formatTask(options) {
  if (options.task) return "cypherTaskJSON="+encodeURIComponent(JSON.stringify(options.task));
  if (options.taskName) return "cypherTask="+options.taskName;
  return "";
}


function setGadgetUrl(sel) {
  $(sel).modal();
  $(sel).draggable();
  var $iframe = $(sel).find("iframe");
  $iframe.attr("src", $iframe.data("src"));
}
