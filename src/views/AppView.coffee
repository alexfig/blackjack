class window.AppView extends Backbone.View
  initialize: ->
    @blackJackView = new BlackjackView(model: @model.get('gameModel'))
    @render()
    @model.on 'change', => @render()
    @model.on 'change:gameModel', => @blackJackView = new BlackjackView(model: @model.get('gameModel'))

  events :
    'click #newGame' : 'startNewGame'

  render: ->
    @$el.empty()
    @$el.append(@blackJackView.render() )
    if @model.get('gameOver') 
      @$el.prepend('<span id="gameStatus">' + @model.get('gameOver') + '</span>')
      @$el.prepend('<button id="newGame">New Game</button>')

  startNewGame: -> 
    window.cardsOnScreen = {}
    @model.trigger 'startNewGame'