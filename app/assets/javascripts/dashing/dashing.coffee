console.log("Yeah! The dashboard has started!")

Dashing.on 'ready', ->
  Dashing.widget_margins ||= [4, 4]
  Dashing.widget_base_dimensions ||= [300, 352]
  Dashing.numColumns ||= 6

  if $(window).width() < 768
    Dashing.widget_margins = [0, 0]
    Dashing.widget_base_dimensions = [$(window).width(), 352]
    Dashing.numColumns = 1
    $('.gridster li').attr("data-sizex", '1')

  contentWidth = (Dashing.widget_base_dimensions[0] + Dashing.widget_margins[0] * 2) * Dashing.numColumns

  if $(window).width() > 768
    Batman.setImmediate ->
      $('.gridster').width(contentWidth)
      $('.gridster ul:first').gridster
        widget_margins: Dashing.widget_margins
        widget_base_dimensions: Dashing.widget_base_dimensions
        avoid_overlapped_widgets: !Dashing.customGridsterLayout
        draggable:
          stop: Dashing.showGridsterInstructions
          start: -> Dashing.currentWidgetPositions = Dashing.getWidgetPositions()

  $.get("/metrics/dashboards/run_jobs")