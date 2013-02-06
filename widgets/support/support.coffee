class Dashing.Support extends Dashing.Widget
  ready: ->
    @audio      = $('#support-alert')[0]
    @muted      = false
    @lastCount  = 0
    @muteButton = $('#mute-button')

    @muteButton.click => this.mute()

  onData: (data) ->
    currentCount = data.items.length

    this.mute() if currentCount > @lastCount && @muted

    if currentCount == 0
      this.clear()
    else
      this.alert()

    @lastCount = data.items.length

  alert: ->
    $(@node).addClass('active')
    @audio.play() unless @muted
  clear: ->
    $(@node).removeClass('active')

  mute: ->
    @muted = !@muted

    if @muted
      @muteButton.addClass('muted')
    else
      @muteButton.removeClass('muted')