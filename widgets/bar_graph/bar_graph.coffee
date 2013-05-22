class Dashing.BarGraph extends Dashing.Widget
  @accessor 'current', ->

  ready: ->
    container = $(@node).parent()
    # Gross hacks. Let's fix this.
    width = (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)
    height = (Dashing.widget_base_dimensions[1] * container.data("sizey"))

    @names = @get('items')
    data = this._data(@get('items'))

    @graph = new Rickshaw.Graph(
      element: @node
      renderer: 'bar'
      width: width
      height: height
      series: [data]
    )

    x_axis = new Rickshaw.Graph.Axis.X(
      graph: @graph
      orientation: 'bottom'
      tickFormat: this._format
    )

    @graph.renderer.unstack = true

    @graph.render()

  onData: (data) ->
    if data.items
      $(data.items).each (i, item) =>
        @graph.series[0].data[i].y = item.count
      @graph.render()

  _data: (items) ->
    color: '#fff'
    data: $.makeArray $(items).map (i, item) =>
      { x: i,  y: item.count }

  _format: (n) =>
    console.debug n
    @names[n].name
