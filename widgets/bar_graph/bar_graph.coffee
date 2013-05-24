class Dashing.BarGraph extends Dashing.Widget
  @accessor 'current', ->

  ready: ->
    @container = $(@node).parent()
    this._initializeGraph(@get('items')) if @get('items')

  onData: (data) ->
    if data.items && @graph
      $(data.items).each (i, item) =>
        @graph.series[0].data[i].y = item.count
      @graph.render()
    else if data.items && !@graph
      this._initializeGraph(data.items)

  _initializeGraph: (items) =>
    @names = items
    data = this._data(items)

    @graph = new Rickshaw.Graph(
      element: @node
      renderer: 'bar'
      width: @_width()
      height: @_height()
      series: [data]
    )

    # x_axis = new Rickshaw.Graph.Axis.X(
    #   graph: @graph
    #   orientation: 'bottom'
    #   tickFormat: this._format
    # )

    @graph.renderer.unstack = true

    @graph.render()

  _data: (items) ->
    color: '#fff'
    data: $.makeArray $(items).map (i, item) =>
      { x: i,  y: item.count }

  _format: (n) =>
    console.debug n
    @names[n].name

  _width: =>
    (Dashing.widget_base_dimensions[0] * @container.data("sizex")) +
     Dashing.widget_margins[0] * 2 * (@container.data("sizex") - 1)
  _height: =>
    (Dashing.widget_base_dimensions[1] * @container.data("sizey"))
