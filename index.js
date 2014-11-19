$(function() {
  $('.js-tab').on('click', function(event) {
    $('.nav-tabs').find('.active').removeClass('active');
    $('.js-map-profit, .js-map-cash, .js-map-eps').addClass('hidden');
    $('.js-map-' + $(event.currentTarget).data('map')).removeClass('hidden');
    $(event.currentTarget).addClass('active');
  });
});
