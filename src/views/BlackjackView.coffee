class window.BlackjackView extends Backbone.View 
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.trigger 'hit', @
    'click .stand-button': -> @model.trigger 'stand', @

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()

    @$('.player-hand-container').html new BlackjackHandView(model: @model, hand:@model.get('playerHand'), name:'Player').el
    @$('.dealer-hand-container').html new BlackjackHandView(model: @model, hand:@model.get('dealerHand'), name:'Dealer').el

    @$el