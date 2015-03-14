class Dashing.BarGraph extends Dashing.Widget
  ready: ->
    @container = $(@node).parent()
    this._initializeGraph(@get('items')) if @get('items')

  onData: (data) ->
    if data.items && @graph
      this._names(data.items)
      $(data.items).each (i, item) =>
        @graph.series[0].data[i].y = item.count
      @graph.render()
      this._overrideStyles()
    else if data.items && !@graph
      this._initializeGraph(data.items)

  # Private

  _initializeGraph: (items) =>
    this._names(items)
    data = this._data(items)

    @graph = new Rickshaw.Graph(
      element: @node
      renderer: 'bar'
      width: @_width()
      height: @_height()
      series: [data]
    )

    x_axis = new Rickshaw.Graph.Axis.X(
      graph: @graph
      tickFormat: this._xAxisLabel
    )

    @graph.renderer.unstack = true

    @graph.render()

    this._overrideStyles()

  _data: (items) ->
    color: '#fff'
    data: $.makeArray $(items).map (i, item) =>
      { x: i,  y: item.count }

  _xAxisLabel: (n) =>
    @names[n]

  # To center the bar graph label we need to use X.5 coordinates
  _names: (data) =>
    @names = {}
    $(data).each (i, item) =>
      @names[i + 0.5] = item.name
      @names[i + 0.5] += " (#{item.count})" if item.count > 0

  _width: =>
    (Dashing.widget_base_dimensions[0] * @container.data("sizex")) +
     Dashing.widget_margins[0] * 2 * (@container.data("sizex") - 1)
  _height: =>
    (Dashing.widget_base_dimensions[1] * @container.data("sizey"))

  _overrideStyles: ->
    jQuery('text').css({opacity: '1', fill: '#AE4434'}).attr('y', -15)
    jQuery('rect').css({opacity: '0.3'})
