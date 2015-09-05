class window.HandView extends Backbone.View

  initialize: ->
    @cardsOnScreen = {}
    @collection.on 'add remove change', => @render()
    @render()


  render: ->
    @$el.children().detach()
    @$el.append @collection.map (card) ->
      if card.id in cardsOnScreen
        new CardView(model: card).$el
      else
        cardsOnScreen[card.id] = true
        new CardView(model: card).$el



    @$el
