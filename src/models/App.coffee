# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'gameOver', false
    @deck = new Deck()
    @set 'gameModel' , new Blackjack({deck: @deck})
    @on('change', => @resetEndGameListener())

    @get('gameModel').on('endGame', (status)=> 
      @set 'gameOver', status
    )

    @on('startNewGame', => 
      @set('gameOver',false)
      if @deck.length < 20 then @deck = new Deck();
      @set('gameModel',  new Blackjack({deck: @deck}) )
    )



  resetEndGameListener: -> @get('gameModel').on('endGame', (status) => @set 'gameOver', status )