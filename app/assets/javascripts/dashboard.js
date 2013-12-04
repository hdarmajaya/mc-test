$(function () {
  $('#start_date').datepicker({ dateFormat: 'yy-mm-dd' });
  $('#search_filename').autocomplete({ source: "/search_suggestion/index" });
});
