class window.HandView extends Backbone.View
  className: 'hand'
  initialize: ->
    @cardViews = []
    @$el.append @collection.map (card) =>
      @cardViews.push( new CardView(model: card) )
      return _.last(@cardViews).$el
    @collection.on('add', => 
      @cardViews.push( new CardView(model: @collection.last() ))
    )
    #@render()



  render: ->
    @$el.children().detach()
    @$el.append _.map(@cardViews, (cardView) =>
      if window.cardsOnScreen[cardView.model.cid]
        cardView.$el.removeClass('dealtCard')
      else
        window.cardsOnScreen[cardView.model.cid] = true
        cardView.$el.addClass('dealtCard')
    )
    @$el
