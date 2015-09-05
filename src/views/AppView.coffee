class window.AppView extends Backbone.View
  initialize: ->
    @render()
    @model.on 'all', => @render()

  events :
    'click #newGame' : 'startNewGame'

  render: ->
    @$el.empty()
    @$el.append(new BlackjackView(model: @model.get('gameModel')).render() )
    if @model.get('gameOver') 
      @$el.append('<span id="gameStatus">' + @model.get('gameOver') + '</span>')
      @$el.append('<button id="newGame">New Game</button>')

  startNewGame: -> @model.trigger 'startNewGame'