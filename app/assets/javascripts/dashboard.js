$(function () {
  $('#start_date').datepicker();
  $('#search_filename').autocomplete({ source: "/search_suggestion/index" });
});
