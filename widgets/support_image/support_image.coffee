class Dashing.SupportImage extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    if data.items.length > 0
      $(@node).addClass('warning')
    else
      $(@node).removeClass('warning')
