# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'gameOver', false
    @set 'gameModel' , new Blackjack()
    @on('change', => @resetEndGameListener())

    @get('gameModel').on('endGame', (status)=> 
      @set 'gameOver', status
    )

    @on('startNewGame', => @set('gameModel',  new Blackjack() ))



  resetEndGameListener: -> @get('gameModel').on('endGame', (status) => @set 'gameOver', status )