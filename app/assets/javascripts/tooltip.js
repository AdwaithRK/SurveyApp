$('.copy-link').tooltip({
  trigger: 'click',
  placement: 'bottom'
});

function setTooltip(message) {
  $('.copy-link').tooltip('hide')
    .attr('data-original-title', "copied link")
    .tooltip('show');
}

function hideTooltip() {
  setTimeout(function () {
    $('.copy-link').tooltip('hide');
  }, 1000);
}