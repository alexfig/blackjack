class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> 
    @render()
    @model.on('change:revealed', => 
      @$el.addClass('reveal')
      setTimeout(=> 
        @$el.removeClass('reveal')
        @$el.addClass('uncover')
        @render()
      ,550)
    )

  render: ->
    @$el.children().detach()
    if @model.get 'revealed' 
      @$el.html @template @model.attributes 
    else
      @$el.html '<img class="flip" src="img/card-back.png">'
      @$el.addClass 'covered' unless @model.get 'revealed'

