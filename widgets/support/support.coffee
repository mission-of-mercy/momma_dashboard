class Dashing.Support extends Dashing.Widget
  ready: ->
    @audio = $('#support-alert')[0]

  onData: (data) ->
    if data.items.length == 0
      this.clear()
    else
      this.alert()

  alert: ->
    $(@node).addClass('active')
    @audio.play()
  clear: ->
    $(@node).removeClass('active')