# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  Morris.Line
    element: 'events_chart'
    data: $('#events_chart').data('events')
    xkey: 'created_at'
    ykeys: ['event_count', 'outages', 'errors', 'slowdowns', 'restarts']
    labels: ['event_count', 'outages', 'errors', 'slowdowns', 'restarts']