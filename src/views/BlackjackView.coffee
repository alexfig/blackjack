class window.BlackjackView extends Backbone.View 
  id: 'game'

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.trigger 'hit', @
    'click .stand-button': -> @model.trigger 'stand', @

  initialize: ->
    @playerHandView = new BlackjackHandView(model: @model, hand:@model.get('playerHand'), name:'Player')
    @dealerHandView = new BlackjackHandView(model: @model, hand:@model.get('dealerHand'), name:'Dealer')
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html @playerHandView.el
    @$('.dealer-hand-container').html @dealerHandView.el

    @$el