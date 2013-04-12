class Dashing.Support extends Dashing.Widget
  ready: ->
    @audio      = $('#support-alert')[0]
    @muted      = false
    @lastCount  = 0
    @muteButton = $('#mute-button')

    @muteButton.click (e) => this.mute(e)

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
    unless @muted
      @audio.load()
      @audio.play()
  clear: ->
    $(@node).removeClass('active')

  mute: (e) ->
    @muted = !@muted

    if @muted
      @muteButton.addClass('muted')
    else
      @muteButton.removeClass('muted')

    false
