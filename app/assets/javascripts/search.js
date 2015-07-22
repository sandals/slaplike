$(document).ready(function() {
  $('.js-search-button').click(function() {
    $('.js-search-alert').html('Searching... this may take a while.');
    $(this).attr('disabled', true);
    $(this).parents('form').submit();
  });
});
